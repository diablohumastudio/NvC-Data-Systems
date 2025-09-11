class_name DeletUserPopup extends Control

signal accept_btn_pressed
signal cancel_btn_pressed

const delete_user_item_pksc: PackedScene = preload("uid://lg5qdekhnaus")
const delete_user_item_btn_group: ButtonGroup = preload("uid://b6q4am4i0feoa")

func _ready() -> void:
	%WarningLabel.text = ""
	UDS.current_user_changed.connect(_on_uds_current_user_changed)
	_set_items()

func _set_items():
	for child in %UserListItemsContainer.get_children():
		child.queue_free()
	await get_tree().process_frame
	for credential in UDS.all_users_credentials.credentials:
		var new_delete_user_item: DeleteUserItem = delete_user_item_pksc.instantiate()
		new_delete_user_item.user_credentials = credential
		%UserListItemsContainer.add_child(new_delete_user_item)
	var first_item = (%UserListItemsContainer.get_child(0) as DeleteUserItem)
	first_item.button_pressed = true

func _on_uds_current_user_changed():
	_set_items()

func _on_accept_btn_pressed() -> void:
	var selected_item: DeleteUserItem = delete_user_item_btn_group.get_pressed_button()
	var user_credential_to_delete: UserCredentials = selected_item.user_credentials
	var err = UDS.delete_user_by_name(user_credential_to_delete.user_name)
	if err == UDS.USER_PROCESSES_ERRORS.CANNOT_DELETE_ALL_USERS:
		%WarningLabel.text = "Cannot delete all users"
	else:
		accept_btn_pressed.emit()

func _on_cancel_btn_pressed() -> void:
	cancel_btn_pressed.emit()
