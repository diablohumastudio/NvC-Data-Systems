class_name UserCredentials extends Resource

@export_storage var user_name: String
@export_storage var password: String

func _init(_user_name: String = "DefaultUser", _password: String = "xxx") -> void:
	user_name = _user_name
	password = _password
