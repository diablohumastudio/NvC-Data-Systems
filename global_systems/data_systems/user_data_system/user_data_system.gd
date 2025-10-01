extends Node

signal current_user_changed()

enum PROPERTIES {
	USERS_CREDENTIALS, 
	USER_NAME, 
	UD_LEVELS, 
	ACHIEVEMENTS, 
	ENEMIES_KILLED, 
	UD_ACHIEVEMENTS, 
	ALLIES,
	MUSIC_VOLUME,
	SFX_VOLUME}

enum USER_PROCESSES_ERRORS{
	OK,
	MAX_NUMBER_OF_USER_CREATED,
	USER_SAME_NAME,
	USER_DONT_EXIST,
	CANNOT_DELETE_ALL_USERS
}

const _USERS_CREDENTIALS_FILE_PATH : String = "user://users.tres"
const _USER_FILE_BASE: String = "user://"

var all_users_credentials: AllUsersCredentials
var current_user_data: UserData 

const MAX_NUMBER_OF_USERS: int = 3

func _init() -> void:
	initialize_users_data()

func initialize_users_data():
	if ResourceLoader.exists(_USERS_CREDENTIALS_FILE_PATH):
		all_users_credentials = load(_USERS_CREDENTIALS_FILE_PATH)
		var current_user_cred: UserCredentials = all_users_credentials.credentials[all_users_credentials.current_user_index]
		current_user_data = load(_USER_FILE_BASE + current_user_cred.user_name + ".tres")
	else:
		all_users_credentials = AllUsersCredentials.new()
		var new_user_credentials: UserCredentials = UserCredentials.new()
		create_new_user(new_user_credentials)

func can_create_new_user(user_credentials: UserCredentials) -> USER_PROCESSES_ERRORS:
	if all_users_credentials.credentials.size() >= MAX_NUMBER_OF_USERS: return USER_PROCESSES_ERRORS.MAX_NUMBER_OF_USER_CREATED
	if user_exists(user_credentials.user_name): return USER_PROCESSES_ERRORS.USER_SAME_NAME
	else: return USER_PROCESSES_ERRORS.OK

func create_new_user(user_credentials: UserCredentials, set_to_current: bool = true) -> UserData:
	if all_users_credentials.credentials.size() >= MAX_NUMBER_OF_USERS: return null

	all_users_credentials.credentials.append(user_credentials)

	var new_user_data: UserData = UserData.new()
	new_user_data.user_name = user_credentials.user_name
	new_user_data.progress.ud_levels = _create_new_ud_levels()
	new_user_data.ud_achievements.ud_achievements = _create_new_ud_achievements()
	new_user_data.allies_inventory.ud_allies = _create_new_ud_allies()
	
	save_user_data_to_disk(new_user_data)
	if set_to_current:
		set_current_user(new_user_data.user_name)

	return new_user_data

func _create_new_ud_allies() -> Array[UDAlly]:
	var ud_allies: Array[UDAlly] = []
	var allies: Array[AllyData] = DataFilesLoader.get_allies_from_res_files()

	for ally in allies: 
		var new_ud_ally: UDAlly = UDAlly.new()
		new_ud_ally.id = ally.id
		var all_ally_levels = ally.levels.duplicate()
		all_ally_levels.append(ally.base_level)
		for ally_level in all_ally_levels as Array[AllyLevelData]:
			if !ally_level: continue
			var new_ud_ally_level: UDAllyLevel = UDAllyLevel.new()
			new_ud_ally_level.id = ally_level.id
			new_ud_ally_level.ally_id = ally_level.ally_id
			new_ud_ally_level.unlock_conditions = ally_level.unlock_conditions
			if ally_level.unlockd_by_default: new_ud_ally_level.unlocked = true
			if ally_level.buyed_by_default: new_ud_ally_level.buyed = true
			new_ud_ally.ud_levels.append(new_ud_ally_level)
		ud_allies.append(new_ud_ally)
	return ud_allies

func _create_new_ud_levels() -> Array[UDLevel]:
	var ud_levels: Array[UDLevel] = []
	var levels : Array[LevelData]  = DataFilesLoader.get_levels_from_res_files()

	for level in levels:
		var new_ud_level: UDLevel = UDLevel.new()
		new_ud_level.id = level.id
		if level.unlockd_by_default: new_ud_level.locked = false
		new_ud_level.conditions = level.conditions
		ud_levels.append(new_ud_level)

	return ud_levels

func _create_new_ud_achievements() -> Array[UDAchievement]:
	var ud_achivements: Array[UDAchievement] = []
	var achievements: Array[AchievementData] = DataFilesLoader.get_achievements_from_res_files()
	
	for achievement in achievements:
		var new_ud_achievement: UDAchievement = UDAchievement.new()
		new_ud_achievement.id = achievement.id
		#otros
		new_ud_achievement.conditions = achievement.conditions
		ud_achivements.append(new_ud_achievement)

	return ud_achivements
	
func set_current_user(user_name: String) -> void:
	if current_user_data:
		save_user_data_to_disk()
	set_current_user_credentials(user_name)
	current_user_data = get_user_data_by_name(user_name)
	current_user_changed.emit()
	save_user_data_to_disk()

func set_current_user_credentials(user_name: String):
	var new_user_index: int
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			new_user_index = all_users_credentials.credentials.find(user_credential)
	all_users_credentials.current_user_index = new_user_index

func get_current_user_credentials() -> UserCredentials:
	return all_users_credentials.credentials[all_users_credentials.current_user_index]

func get_user_data_by_name(user_name: String) -> UserData:
	var user_data: UserData
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			user_data = load(_USER_FILE_BASE + user_credential.user_name + ".tres")
			return user_data
	return null

func user_exists(user_name: String)->bool:
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			return true
	return false

func is_user_password_valid(user_name: String, password: String) -> bool:
	if !user_exists(user_name): push_error("No user with this name")
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			if user_credential.password == password:
				return true
	return false

func save_user_data_to_disk(user_data: UserData = current_user_data) -> void:
	save_user_credentials()
	var result = ResourceSaver.save(user_data, _USER_FILE_BASE + user_data.user_name + ".tres")
	assert(result == OK)

func save_user_credentials():
	var result : Error = ResourceSaver.save(all_users_credentials, _USERS_CREDENTIALS_FILE_PATH)
	assert(result == OK)

func delete_user_by_name(user_name: String) -> USER_PROCESSES_ERRORS:
	if !user_exists(user_name): return USER_PROCESSES_ERRORS.USER_DONT_EXIST
	var size = all_users_credentials.credentials.size()
	if all_users_credentials.credentials.size() == 1 : return USER_PROCESSES_ERRORS.CANNOT_DELETE_ALL_USERS
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			var index = all_users_credentials.credentials.find(user_credential)
			all_users_credentials.credentials.pop_at(index)
			DirAccess.open(_USER_FILE_BASE).remove(user_name + ".tres")
	set_current_user(all_users_credentials.credentials[0].user_name)
	save_user_data_to_disk()
	return USER_PROCESSES_ERRORS.OK

func get_property(property: PROPERTIES):
	match property:
		PROPERTIES.USERS_CREDENTIALS:
			return all_users_credentials
		PROPERTIES.USER_NAME:
			return current_user_data.user_name
		PROPERTIES.UD_LEVELS:
			return current_user_data.progress.ud_levels
		PROPERTIES.ACHIEVEMENTS:
			return current_user_data.achievements.achievements
		PROPERTIES.ENEMIES_KILLED:
			return current_user_data.stats.total_enemies_killed
		PROPERTIES.UD_ACHIEVEMENTS:
			return current_user_data.ud_achievements
		PROPERTIES.ALLIES:
			return current_user_data.allies_inventory.ud_allies
		PROPERTIES.MUSIC_VOLUME:
			return current_user_data.settings.music_volume
		PROPERTIES.SFX_VOLUME:
			return current_user_data.settings.sfx_volume

func get_ud_level_by_id(id: LevelData.IDs) -> UDLevel:
	for ud_level in current_user_data.progress.ud_levels as Array[UDLevel]:
		if ud_level.id == id:
			return ud_level
	return null

func get_ud_achievement_by_id(id: AchievementData.IDs) -> UDAchievement:
	for ud_achivement in current_user_data.ud_achievements.ud_achievements as Array[UDAchievement]:
		if ud_achivement.id == id:
			return ud_achivement
	return null

func get_ud_ally_by_id(id: AllyData.IDs):
	for ud_ally in current_user_data.allies_inventory.ud_allies as Array[UDAlly]:
		if ud_ally.id == id:
			return ud_ally
	return null

func get_ud_ally_level_by_id_in_ally(id: String, ally_id: AllyData.IDs) -> UDAllyLevel:
	var ud_ally: UDAlly = get_ud_ally_by_id(ally_id)
	for ud_ally_level in ud_ally.ud_levels as Array[UDAllyLevel]:
		if ud_ally_level.id == id:
			return ud_ally_level
	return null

func get_ally_level_by_id_in_market_btn_group(id: String, ally_id: AllyData.IDs) -> AllyLevelData:
	#var ally_level: UDAlly 
	var ally_lvl_btns_group : ButtonGroup = load("uid://ktw76hems2h8")
	for ally_lvl_btn in ally_lvl_btns_group.get_buttons() as Array[AllyLevelData]:
		if ally_lvl_btn.ally_level.id == id:
			return ally_lvl_btn.ally_level
	return null

func listen_property(property: PROPERTIES, callback: Callable):
		match property:
			PROPERTIES.ENEMIES_KILLED:
				current_user_data.stats.total_enemies_killed_changed.connect(callback)
