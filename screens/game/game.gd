class_name Game extends Control

var level: LevelData : set = _set_level

func _set_level(new_value: LevelData) -> void:
	level = new_value
	GSS.level = level
	GSS.reset_values()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MAIN_MENU))

func _on_go_back_to_test_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))
