class_name ExitToMenuConfirmPopup extends Control

signal exit_confirmed

func _on_yes_button_pressed() -> void:
	exit_confirmed.emit()

func _on_no_button_pressed() -> void:
	hide()
