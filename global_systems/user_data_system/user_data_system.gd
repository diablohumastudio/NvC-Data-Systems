extends Node

signal current_user_changed()

enum PROPERTIES {USERS_CREDENTIALS, USER_NAME, UD_LEVELS, ACHIEVEMENTS, ENEMIES_KILLED, UD_ACHIEVEMENTS}

const _USERS_CREDENTIALS_FILE_PATH : String = "user://users.tres"
const _USER_FILE_BASE: String = "user://"

var users_credentials: UsersCredentials
var current_user_data: UserData 

func _ready() -> void:
	initialize_users_data()

func initialize_users_data():
	if ResourceLoader.exists(_USERS_CREDENTIALS_FILE_PATH):
		users_credentials = load(_USERS_CREDENTIALS_FILE_PATH)
		var current_usr_cred: UserCredentials = users_credentials.credentials[users_credentials.current_user_index]
		current_user_data = load(_USER_FILE_BASE + current_usr_cred.user_name + ".tres")
	else:
		users_credentials = UsersCredentials.new()
		var new_user_credentials: UserCredentials = UserCredentials.new()
		create_new_user(new_user_credentials)

func create_new_user(user_credentials: UserCredentials, set_to_current: bool = true) -> UserData:
	users_credentials.credentials.append(user_credentials)

	var new_user_data: UserData = UserData.new()
	new_user_data.user_name = user_credentials.user_name
	new_user_data.progress.ud_levels = DataFilesLoader.create_ud_levels_from_res_files()
	new_user_data.ud_achievements.ud_achievements = DataFilesLoader.create_ud_achievements_from_res_files()
	
	if set_to_current:
		var new_user_index: int = users_credentials.credentials.find(user_credentials)
		users_credentials.current_user_index = new_user_index
		current_user_data = new_user_data
		current_user_changed.emit()
	
	var result : Error = ResourceSaver.save(users_credentials, _USERS_CREDENTIALS_FILE_PATH)
	assert(result == OK)
	result = ResourceSaver.save(new_user_data, _USER_FILE_BASE + new_user_data.user_name + ".tres")
	assert(result == OK)

	return new_user_data

func set_current_user(user_name: String) -> void:
	save_user_data_to_disk()
	var current_user_credentials: UserCredentials
	for user_credential in users_credentials.credentials:
		if user_credential.user_name == user_name:
			current_user_credentials = user_credential
	var new_user_index: int = users_credentials.credentials.find(current_user_credentials)
	users_credentials.current_user_index = new_user_index
	current_user_data = load(_USER_FILE_BASE + current_user_credentials.user_name + ".tres")
	current_user_changed.emit()

func user_exists(user_name: String)->bool:
	for user_credential in users_credentials.credentials:
		if user_credential.user_name == user_name:
			return true
	return false

func is_user_password_valid(user_name: String, password: String) -> bool:
	if user_exists(user_name): push_error("No user with this name")
	for user_credential in users_credentials.credentials:
		if user_credential.user_name == user_name:
			if user_credential.password == password:
				return true
	return false

func save_user_data_to_disk() -> void:
	var result : Error = ResourceSaver.save(users_credentials, _USERS_CREDENTIALS_FILE_PATH)
	assert(result == OK)
	result = ResourceSaver.save(current_user_data, _USER_FILE_BASE + current_user_data.user_name + ".tres")
	assert(result == OK)

func get_property(property: PROPERTIES):
	match property:
		PROPERTIES.USERS_CREDENTIALS:
			return users_credentials
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
