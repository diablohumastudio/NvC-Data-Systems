class_name RegisterPopUp extends UserProcessPopUp

func _on_acept_btn_pressed() -> void:
	var new_user_data: UserData
	%UserName.check_is_empty()
	%UserPassword.check_is_empty()

	if %UserName.text != "" and %UserPassword.text != "":
		super()
		var new_credentials = UserCredentials.new()
		new_credentials.user_name = %UserName.text
		new_credentials.password = %UserPassword.text
		UDS.create_user_data(new_credentials)

func _on_go_back_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.WELCOME_MENU)
