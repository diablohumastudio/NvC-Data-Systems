@tool
class_name LevelBtn extends Button

@export var level: Level : set = _set_level

func _set_level(new_value: Level):
	level = new_value
	_change_color_and_text()

func _change_color_and_text() -> void:
	self.text = level.level_name
	if level.ud_level.completed:
		disabled = false
		modulate = Color.GREEN
	elif level.ud_level.locked == false:
		disabled = false
		modulate = Color.AQUA
	else:
		modulate = Color.WHITE
		disabled = true

func _on_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.GAME, {"level": level})
