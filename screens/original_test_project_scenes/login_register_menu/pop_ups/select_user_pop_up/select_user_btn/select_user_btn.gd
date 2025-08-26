class_name SelectUserBtn extends Button

@export var user_credentials: UserCredentials : set = _set_user_credentials

var base_text: String

func _set_user_credentials(new_value: UserCredentials) -> void:
	user_credentials = new_value
	base_text = "Select: '" + user_credentials.user_name+ "' user"
	text = base_text

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		UDS.set_current_user(user_credentials.user_name)
		modulate = Color.AQUAMARINE
		text = base_text + "    SELECTED"
	else: 
		modulate = Color.WHITE
		text = base_text
