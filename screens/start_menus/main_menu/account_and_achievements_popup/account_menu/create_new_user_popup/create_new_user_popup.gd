class_name CreateNewUserPopUp extends Control

signal accept_btn_pressed
signal cancel_btn_pressed

func _ready() -> void:
	%WarningLabel.text = ""

func _on_accept_btn_pressed() -> void:
	if %NewNameTextEdit.text == "":
		%WarningLabel.text = "Name MUST not be empty"
		return
	var new_user: UserData
	var new_credentials = UserCredentials.new()
	new_credentials.user_name = %NewNameTextEdit.text
	new_credentials.password = "new_password"
	var can_create_user: UDS.USER_PROCESSES_ERRORS = UDS.can_create_new_user(new_credentials)
	if can_create_user == UDS.USER_PROCESSES_ERRORS.MAX_NUMBER_OF_USER_CREATED:
		%WarningLabel.text = "MAXIMUN number of users created"
	elif can_create_user == UDS.USER_PROCESSES_ERRORS.USER_SAME_NAME:
		%WarningLabel.text = "SAME NAME user already created"
	elif can_create_user == UDS.USER_PROCESSES_ERRORS.OK:
		UDS.create_new_user(new_credentials)
		accept_btn_pressed.emit()

func _on_cancel_btn_pressed() -> void:
	accept_btn_pressed.emit()
