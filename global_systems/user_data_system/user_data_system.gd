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
	_user_data.progress.ud_levels = _create_ud_levels_from_res_files()
	return _user_data

func _create_ud_levels_from_res_files() -> Array[UDLevel]:
	var _ud_levels: Array[UDLevel]
	var dir := DirAccess.open("res://data/ud_levels/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: UDLevel = load(dir.get_current_dir() + "/" + file)
		print(file, "after load")
		_ud_levels.append(ud_level.duplicate())
		print(file, "after duplicate")
	print_stack()
	return _ud_levels

func save_to_disk() -> void:
	var result := ResourceSaver.save(current_user_data, _USER_FILE_BASE + current_user_data.user_name + ".tres")
	assert(result == OK)
	result = ResourceSaver.save(users_credentials, _USERS_CREDENTIALS_FILE_PATH)
