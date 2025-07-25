extends Node

signal current_user_changed()

enum PROPERTIES {USERS_CREDENTIALS, USER_NAME, UD_LEVELS, ACHIEVEMENTS, ENEMIES_KILLED, UD_ACHIEVEMENTS, ALLIES}

const _USERS_CREDENTIALS_FILE_PATH : String = "user://users.tres"
const _USER_FILE_BASE: String = "user://"

var all_users_credentials: AllUsersCredentials
var current_user_data: UserData 

func _init() -> void:
	initialize_users_data()

func initialize_users_data():
	if ResourceLoader.exists(_USERS_CREDENTIALS_FILE_PATH):
		all_users_credentials = load(_USERS_CREDENTIALS_FILE_PATH)
		var current_user_cred: UserCredentials = all_users_credentials.credentials[all_users_credentials.current_user_index]
		current_user_data = load(_USER_FILE_BASE + current_user_cred.user_name + ".tres")
		#ACS.current_user_name = current_user_cred.user_name
	else:
		all_users_credentials = AllUsersCredentials.new()
		var new_user_credentials: UserCredentials = UserCredentials.new()
		create_new_user(new_user_credentials)

func create_new_user(user_credentials: UserCredentials, set_to_current: bool = true) -> UserData:
	all_users_credentials.credentials.append(user_credentials)

	var new_user_data: UserData = UserData.new()
	new_user_data.user_name = user_credentials.user_name
	new_user_data.progress.ud_levels = _create_new_ud_levels()
	new_user_data.ud_achievements.ud_achievements = DataFilesLoader.create_ud_achievements_from_res_files()
	new_user_data.allies_inventory.ud_allies = DataFilesLoader.create_ud_allies_from_res_files()
	
	save_user_data_to_disk(new_user_data)
	if set_to_current:
		set_current_user(new_user_data.user_name)

	return new_user_data

func _create_new_ud_levels() -> Array[UDLevel]:
	var ud_levels: Array[UDLevel] = []
	var levels : Array[Level]  = DataFilesLoader.get_levels_from_res_files()

	for level in levels:
		var new_ud_level: UDLevel = UDLevel.new()
		new_ud_level.id = level.id
		if level.unlockd_by_default: new_ud_level.locked = false
		new_ud_level.conditions = level.conditions
		ud_levels.append(new_ud_level)

	return ud_levels
	
func set_current_user(user_name: String) -> void:
	if current_user_data:
		save_user_data_to_disk()
	set_all_users_cred_by_name(user_name)
	current_user_data = get_user_data_by_name(user_name)
	#ACS.current_user_name = user_name
	current_user_changed.emit()
	save_user_data_to_disk()

func set_all_users_cred_by_name(user_name: String):
	var new_user_index: int
	for user_credential in all_users_credentials.credentials:
		if user_credential.user_name == user_name:
			new_user_index = all_users_credentials.credentials.find(user_credential)
	all_users_credentials.current_user_index = new_user_index

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
	var result : Error = ResourceSaver.save(all_users_credentials, _USERS_CREDENTIALS_FILE_PATH)
	assert(result == OK)
	result = ResourceSaver.save(user_data, _USER_FILE_BASE + user_data.user_name + ".tres")
	assert(result == OK)

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

func get_ud_level_by_id(id: Level.IDs) -> UDLevel:
	for ud_level in current_user_data.progress.ud_levels as Array[UDLevel]:
		if ud_level.id == id:
			return ud_level
	return null

func listen_property(property: PROPERTIES, callback: Callable):
		match property:
			PROPERTIES.ENEMIES_KILLED:
				current_user_data.stats.total_enemies_killed_changed.connect(callback)
