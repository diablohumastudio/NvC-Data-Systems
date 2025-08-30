extends Control

var current_user_credential: UserCredentials = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]

func _on_register_button_pressed() -> void:
	%RegisterPopUp.show()
	pass # Replace with function body.

func _on_username_text_edit_text_changed() -> void:
	current_user_credential.user_name =  %UsernameTextEdit.text
