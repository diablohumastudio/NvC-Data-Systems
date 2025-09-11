class_name DeleteUserItem extends TextureButton

const check_sign_texture: Texture2D = preload("uid://c3psaa220khtt")

var user_credentials: UserCredentials : set = _set_user_credentials

func _set_user_credentials(new_value: UserCredentials):
	user_credentials = new_value
	%NameLabel.text = user_credentials.user_name

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%CheckSign.texture = check_sign_texture
	else:
		%CheckSign.texture = null
