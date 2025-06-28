extends Control

func _ready() -> void:
	for user_credential in UDS.current_user_data

func _on_close_btn_pressed() -> void:
	hide()

func _on_go_back_pressed() -> void:
	hide()
