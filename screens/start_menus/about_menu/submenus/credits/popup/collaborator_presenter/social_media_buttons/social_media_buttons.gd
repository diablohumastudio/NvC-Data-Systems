class_name SocialMediaButtons extends GridContainer

const SOCIAL_MEDIA_BTN_PATH : String = "uid://cdvt75w8gi0s0"

func _ready() -> void:
	_clear_buttons()

func create_buttons(collaborator:Collaborator) -> void:
	if collaborator.x_user_name != "":
		var social_media_btn : SocialMediaBtn = load(SOCIAL_MEDIA_BTN_PATH).instantiate()
		social_media_btn.type = social_media_btn.TYPES.X
		add_child(social_media_btn)
		social_media_btn.set_button(collaborator.x_user_name)
		social_media_btn.pressed.connect(_on_social_media_btn_pressed.bind(social_media_btn))
	if collaborator.steam_user_name != "":
		var social_media_btn : SocialMediaBtn = load(SOCIAL_MEDIA_BTN_PATH).instantiate()
		social_media_btn.type = social_media_btn.TYPES.STEAM
		add_child(social_media_btn)
		social_media_btn.set_button(collaborator.steam_user_name)
		social_media_btn.pressed.connect(_on_social_media_btn_pressed.bind(social_media_btn))
	if collaborator.instagram_user_name != "":
		var social_media_btn : SocialMediaBtn = load(SOCIAL_MEDIA_BTN_PATH).instantiate()
		social_media_btn.type = social_media_btn.TYPES.INSTAGRAM
		add_child(social_media_btn)
		social_media_btn.set_button(collaborator.instagram_user_name)
		social_media_btn.pressed.connect(_on_social_media_btn_pressed.bind(social_media_btn))
	if collaborator.facebook_user_name != "":
		var social_media_btn : SocialMediaBtn = load(SOCIAL_MEDIA_BTN_PATH).instantiate()
		social_media_btn.type = social_media_btn.TYPES.FACEBOOK
		add_child(social_media_btn)
		social_media_btn.set_button(collaborator.facebook_user_name)
		social_media_btn.pressed.connect(_on_social_media_btn_pressed.bind(social_media_btn))


func _on_social_media_btn_pressed(_social_media_btn:SocialMediaBtn) -> void:
	print("pressed")

func _clear_buttons() -> void:
	for child in get_children():
		child.queue_free()
