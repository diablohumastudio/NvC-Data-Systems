class_name LevelNamePresenter extends Label

var level: Level : set = _set_level

func _set_level(new_value: Level):
	level = new_value
	text = level.level_name
