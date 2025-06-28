class_name SelectUserBtn extends Button

@export var user_credentials: UserCredentials : set = _set_user_credentials

func _set_user_credentials(new_value: UserCredentials) -> void:
	user_credentials = new_value
	self.text = "Select: '" + user_credentials.user_name+ "' user"
