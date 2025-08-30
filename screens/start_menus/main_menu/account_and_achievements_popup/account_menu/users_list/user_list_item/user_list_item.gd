class_name UserListItem extends TextureButton

const check_sign_texture: Texture2D = preload("uid://c3psaa220khtt")
const plus_sign_texture: Texture2D = preload("uid://4mhi0mp1tu2s")

var user_credentials: UserCredentials

func _ready() -> void:
	update_visuals()

func update_visuals():
	if !user_credentials: 
		modulate = Color.DIM_GRAY
		%SelectedIcon.texture = plus_sign_texture
		return
	%SlotLabel.text = user_credentials.user_name
	print("my index",UDS.all_users_credentials.credentials.find(user_credentials))
	print("current index",UDS.all_users_credentials.current_user_index)
	if UDS.all_users_credentials.credentials.find(user_credentials) == UDS.all_users_credentials.current_user_index:
		%SelectedIcon.texture = check_sign_texture
	else:
		%SelectedIcon.texture = null
