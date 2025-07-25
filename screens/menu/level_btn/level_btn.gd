@tool
class_name LevelBtn extends Button

@export var level: Level : set = _set_level

func _set_level(new_value: Level):
	level = new_value
	_change_color_and_text()

func _change_color_and_text() -> void:
	self.text = level.level_name
	if level.get_ud_level().completed:
		disabled = false
		self_modulate = Color.GREEN
	elif level.get_ud_level().locked == false:
		disabled = false
		self_modulate = Color.AQUA
	else:
		disabled = true
		self_modulate = Color.WHITE
	if level.get_ud_level().completed_all_canons:
		%CanonsLbl.self_modulate = Color.RED

func _on_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.GAME, {"level": level})
