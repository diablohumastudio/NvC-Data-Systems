extends Control

@export var popup_menu: Node

func _on_show_pause_pop_up_btn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		popup_menu._show()
	else:
		popup_menu._hide()
