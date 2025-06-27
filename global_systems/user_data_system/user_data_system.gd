extends Node

const _USERS_CREDENTIALS_FILE_PATH : String = "user://users.tres"
const _USER_FILE_BASE: String = "user://"

var users_credentials: UsersCredentials
var current_user_data: UserData 

func _ready() -> void:
	initialize_current_user_data()

func initialize_current_user_data():
	if ResourceLoader.exists(_USERS_CREDENTIALS_FILE_PATH):
		users_credentials = load(_USERS_CREDENTIALS_FILE_PATH)
		var current_user_credentials: UserCredentials = users_credentials.credentials[users_credentials.current_user_index]
		current_user_data = load(_USER_FILE_BASE + current_user_credentials.user_name + ".tres")
	else:
		users_credentials = UsersCredentials.new()
		var new_user_credentials: UserCredentials = UserCredentials.new()
		current_user_data = create_user_data(new_user_credentials)
		users_credentials.credentials.append(new_user_credentials)
		users_credentials.current_user_index = 0

func create_user_data(user_credentials: UserCredentials) -> UserData:
	var _user_data: UserData
	_user_data = UserData.new()
	_user_data.user_name = user_credentials.user_name
	_user_data.progress.ud_levels = DataFilesLoader.create_ud_levels_from_res_files()
	_user_data.ud_achievements.ud_achievements = DataFilesLoader.create_ud_achievements_from_res_files()
	return _user_data

func save_user_data_to_disk() -> void:
	var result := ResourceSaver.save(current_user_data, _USER_FILE_BASE + current_user_data.user_name + ".tres")
	assert(result == OK)
	result = ResourceSaver.save(users_credentials, _USERS_CREDENTIALS_FILE_PATH)
