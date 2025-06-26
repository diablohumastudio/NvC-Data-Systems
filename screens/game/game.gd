extends Control

var level: Level : set = _set_level

func _set_level(new_value: Level) -> void:
	level = new_value
	%LevelNamePresenter.text = level.level_name

func _on_win_btn_pressed() -> void:
	level.ud_level.completed_condition.is_fullfilled = true

func _on_go_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/menu/menu.tscn")
