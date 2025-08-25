extends Control

func _ready() -> void:
	%WelcomeLabel.text = UDS.get_property(UDS.PROPERTIES.USER_NAME)

func _on_goto_menu_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))

func _on_change_user_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.LOGIN_REGISTER_MENU))
