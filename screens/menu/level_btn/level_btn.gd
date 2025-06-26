@tool
class_name LevelBtn extends Control

@export var level: Level : set = _set_level

func _set_level(new_value: Level):
	level = new_value
	_change_color_and_text()

func _change_color_and_text() -> void:
	self.text = level.level_name
	if level.ud_level.completed:
		modulate = Color.GREEN
	elif level.ud_level.locked == false:
		modulate = Color.AQUA
	else:
		modulate = Color.WHITE

func _on_pressed() -> void:
	SceneManagerSystem.change_scene(load("res://screens/game/game.tscn"), {"level": level})
