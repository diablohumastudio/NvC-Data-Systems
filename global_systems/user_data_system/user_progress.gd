class_name UserProgress extends Resource

@export var ud_levels: Array[UDLevel] 

func _init() -> void:
	_create_ud_levels()

func _create_ud_levels():
	var dir := DirAccess.open("res://data/ud_levels/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: UDLevel = load(dir.get_current_dir() + "/" + file)
		ud_levels.append(ud_level.duplicate())
