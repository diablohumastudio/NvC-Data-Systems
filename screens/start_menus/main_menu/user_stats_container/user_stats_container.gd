class_name UserStatsContainer extends Control

signal show_account_popup_btn_pressed

var user_name : String : set = _set_user_name
var user_balance : int : set = _set_user_balance
var _stats_opened : bool 

@onready var _balance_label : Label = $"%BalanceLabel"
@onready var _user_name_label : Label = $"%UserNameLabel"
@onready var display_stats_button : TextureButton = $%UsernameContainer as TextureButton


func _ready():
	#Set user stats container
	user_name = UDS.get_property(UDS.PROPERTIES.USER_NAME)
	user_balance = UDS.current_user_data.player_balance
	_set_user_balance(user_balance)
	pass

func _set_user_name(new_value:String):
	user_name = new_value
	_user_name_label.text = user_name

func _set_user_balance(new_value:int):
	user_balance = new_value
	
	_balance_label.text = str(user_balance)

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
