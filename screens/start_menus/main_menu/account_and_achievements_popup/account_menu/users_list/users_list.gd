extends Control

signal create_new_user_requested

const user_list_item_pksc: PackedScene = preload("uid://dvlb36pw703xc")

var current_user_credential: UserCredentials = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]

func _on_uds_current_user_changed():
	current_user_credential = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]
	_set_items()

func _ready() -> void:
	UDS.current_user_changed.connect(_on_uds_current_user_changed)
	_set_items()

func _set_items():
	for child in get_children():
		child.queue_free()

	for ii in UDS.all_users_credentials.credentials.size():
		var user_credential: UserCredentials 
		user_credential = UDS.all_users_credentials.credentials[ii] if UDS.all_users_credentials.credentials.size()> ii else null
		
		var new_user_list_item: UserListItem = user_list_item_pksc.instantiate()
		new_user_list_item.user_credentials = user_credential
		new_user_list_item.pressed.connect(_on_slot_button_pressed.bind(new_user_list_item))
		var user_list_item_label: Label = new_user_list_item.get_node("SlotLabel")
		if user_credential: user_list_item_label.text = user_credential.user_name
		add_child(new_user_list_item)
	_set_children_visuals()

func _on_slot_button_pressed(user_list_item: UserListItem) -> void:
	if user_list_item.user_credentials == null:
		create_new_user_requested.emit()
		return
	UDS.all_users_credentials.current_user_index = UDS.all_users_credentials.credentials.find(user_list_item.user_credentials)
	UDS.set_current_user(user_list_item.user_credentials.user_name)
	_set_children_visuals()

func _set_children_visuals():
	for item: UserListItem in get_children():
		item.update_visuals()
