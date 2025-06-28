class_name RegisterPopUp extends UserProcessPopUp

func _on_acept_btn_pressed() -> void:
	var new_user_data: UserData
	%UserName.check_is_empty()
	%UserPassword.check_is_empty()

	if %UserName.text != "" and %UserPassword.text != "":
		super()
		#var new_credentials = User.new()
		#new_credentials.user_name = %UserName.text
		#new_credentials.password = %UserPassword.text
		#UDS.add_new_user(new_credentials, true)

func _on_go_back_pressed() -> void:
	var welcome_menu_user = load("res://screens/welcome_menu/welcome_menu_user/welcome_menu_user.tscn").instantiate()
	SMS.get_container("Main").goto_scene(welcome_menu_user)
