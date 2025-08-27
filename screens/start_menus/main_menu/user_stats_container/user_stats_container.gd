class_name UserStatsContainer extends Control

signal show_account_popup_btn_pressed

var user_credentials: UserCredentials

var user_name : String
var user_balance : int
var _stats_opened : bool 

@onready var _balance_label : Label = $"%BalanceLabel"
@onready var _user_name_label : Label = $"%UserNameLabel"
@onready var display_stats_button : TextureButton = $%UsernameContainer as TextureButton

func _ready():
	user_credentials = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]
	_set_visuals()
	UDS.current_user_changed.connect(_on_uds_current_user_changed)

func _on_uds_current_user_changed():
	user_credentials = UDS.all_users_credentials.credentials[UDS.all_users_credentials.current_user_index]
	_set_visuals()

func _set_visuals():
	_user_name_label.text = user_credentials.user_name
	_balance_label.text = str(UDS.current_user_data.player_balance)

func _on_username_container_pressed():
	if _stats_opened == false:
		show_items()
	elif _stats_opened == true:
		hide_items()

func show_items():
		$Arrow.visible = false
		$AnimationPlayer.play("_drop_down")
		_stats_opened = true

func hide_items():
		$AnimationPlayer.play("_close")
		_stats_opened = false
		$Arrow.visible = true

func _on_username_container_mouse_entered():
	if _stats_opened == false:
		$Arrow.visible = true
	$Arrow/AnimationPlayer.play("_appear")
	$Arrow/AnimationPlayer.queue("_bounce")

func _on_username_container_mouse_exited():
	$Arrow/AnimationPlayer.play_backwards("_appear")

func _on_username_container_focus_entered():
	if _stats_opened == false:
		$Arrow.visible = true
	$Arrow/AnimationPlayer.play("_appear")
	$Arrow/AnimationPlayer.queue("_bounce")

func _on_username_container_focus_exited():
	$Arrow/AnimationPlayer.play_backwards("_appear")

func _on_show_account_popup_btn_pressed() -> void:
	show_account_popup_btn_pressed.emit()
