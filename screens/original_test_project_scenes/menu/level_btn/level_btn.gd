class_name LevelBtn extends Button

@export var level: LevelData : set = _set_level

func _set_level(new_value: LevelData):
	if !new_value: return
	level = new_value
	_change_color_and_text()

func _change_color_and_text() -> void:
	self.text = level.level_name
	if level.get_saved_ud_level().completed:
		disabled = false
		self_modulate = Color.GREEN
	elif level.get_saved_ud_level().locked == false:
		disabled = false
		self_modulate = Color.AQUA
	else:
		disabled = true
		self_modulate = Color.WHITE
	if level.get_saved_ud_level().completed_all_canons:
		%CanonsLbl.self_modulate = Color.RED

func _on_pressed() -> void:
	GSS.level = level
	GSS.reset_values()
	SMS.change_scene(load(GC.SCREENS_UIDS.GAME))
