extends VBoxContainer

func _on_add_50_btn_pressed() -> void:
	GSS.add_value_to_balance(50)

func _on_remove_50_btn_pressed() -> void:
	GSS.substract_value_from_balance(50)
