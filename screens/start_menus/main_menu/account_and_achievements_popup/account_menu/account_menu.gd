extends Control

signal create_new_user_btn_pressed

var current_user_credential: UserCredentials = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]

func _ready() -> void:
	UDS.current_user_changed.connect(_on_uds_current_user_changed)
	_set_visuals()

func _on_uds_current_user_changed():
	current_user_credential = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]
	_set_visuals()

func _on_username_text_edit_text_changed() -> void:
	current_user_credential.user_name =  %UsernameTextEdit.text

func _on_new_user_btn_pressed() -> void:
	create_new_user_btn_pressed.emit()

func _set_visuals():
	%UsernameTextEdit.text = current_user_credential.user_name
