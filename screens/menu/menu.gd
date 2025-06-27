class_name Menu extends Control

func _on_save_btn_pressed() -> void:
	UDS.save_user_data_to_disk()

func _on_goto_achievements_screen_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.ACHIEVEMENTS)

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.PREMENU)
