class_name Menu extends Control

func _on_save_btn_pressed() -> void:
	UserDataSystem.save_to_disk()
