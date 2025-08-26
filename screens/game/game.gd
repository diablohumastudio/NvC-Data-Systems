class_name Game extends Control

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.STALINGRAD_SUMMER_LEVELS_MENU))
