class_name LogInPopUp extends UserProcessPopUp

func _on_acept_btn_pressed() -> void:
	#if !UDS.user_exists(%UserName.text):
		#%UserName.warn_validation("User not found")
		#return
	#elif !UDS.validate_user_password(%UserName.text, %UserPassword.text):
		#%UserPassword.warn_validation("Password doesnt match")
		#return
	#else:
		#UDS.change_user(%UserName.text)
		super()

func _on_go_back_pressed() -> void:
	var welcome_menu_user = load("res://screens/welcome_menu/welcome_menu_user/welcome_menu_user.tscn").instantiate()
	SMS.get_container("Main").goto_scene(welcome_menu_user)
