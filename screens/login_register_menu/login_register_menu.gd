extends Control

func _ready() -> void:
	#%WelcomeLabel.text = UDS.get_property(UDS.PROPERTIES.USER_NAME)
	pass
	
func _on_goto_menu_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)

func _on_goto_login_btn_pressed() -> void:
	%LoginPopUp.show()

func _on_goto_register_btn_pressed() -> void:
	%RegisterPopUp.show()

func _on_goto_select_user_btn_pressed() -> void:
	%SelectUserPopUp.show()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.WELCOME_MENU)
