class_name UserProcessPopUp extends Control

func _on_close_btn_pressed() -> void:
	hide()

func _on_go_back_pressed() -> void:
	hide()

func _on_acept_btn_pressed() -> void:
	%GoBack.show()
	%AceptBtn.hide()
	%ProcessAceptedLabel.show()
	%CloseBtn.hide()
	
