extends Node

const _FILE_NAME : String = "user://user_data.tres"

var user_data: UserData 

func _ready() -> void:
	load_user_data()

func load_user_data():
	if ResourceLoader.exists(_FILE_NAME):
		user_data = load(_FILE_NAME)
	else:
		user_data = UserData.new()

func save_to_disk() -> void:
	var result := ResourceSaver.save(user_data, _FILE_NAME)
	assert(result == OK)
