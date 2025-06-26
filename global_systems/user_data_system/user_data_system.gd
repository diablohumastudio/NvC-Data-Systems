extends Node

const _FILE_NAME : String = "user://user_data.tres"

var user_data: UserData 

func _ready() -> void:
	load_user_data()

func load_user_data():
	if ResourceLoader.exists(_FILE_NAME):
		user_data = load(_FILE_NAME)
	else:
	_user_data.progress.ud_levels = _create_ud_levels_from_res_files()
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
	var result := ResourceSaver.save(user_data, _FILE_NAME)
	assert(result == OK)
