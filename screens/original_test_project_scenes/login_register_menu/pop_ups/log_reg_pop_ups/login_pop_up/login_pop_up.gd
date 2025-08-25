class_name LogInPopUp extends UserProcessPopUp

func _on_acept_btn_pressed() -> void:
	if !UDS.user_exists(%UserName.text):
		%UserName.warn_validation("User not found")
		return
	elif !UDS.is_user_password_valid(%UserName.text, %UserPassword.text):
		%UserPassword.warn_validation("Password doesnt match")
		return
	else:
		UDS.set_current_user(%UserName.text)
		super()

func _on_go_back_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.WELCOME_MENU))
