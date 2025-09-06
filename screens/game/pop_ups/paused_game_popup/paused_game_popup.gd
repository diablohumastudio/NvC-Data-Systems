class_name PausedGamePopup extends Control

signal cancel_input_received
signal start_key_input_received

const MAIN_MENU = "uid://cflg2ypu25js2"
const GAME_SCREEN = "uid://0yp607cucppk"

var level_to_replay : LevelData
var _saved_settings = UDS.current_user_data.settings

func _ready():
	show_popup()

func _hide_popup():
	AudioSystem.post_event(AK.EVENTS.RESET_POPUP_FILTER)
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	%ResumePlayer.play("continue_pressed")
	await %ResumePlayer.animation_finished
	get_tree().paused = false
	%AnimationPlayer.play("dissapear")
	await %AnimationPlayer.animation_finished
	self.visible = false
	
func show_popup():
	AudioSystem.post_event(AK.EVENTS.SET_POPUP_FILTER)
	%AnimationPlayer.play("appear")

func _on_resume_game_button_pressed() -> void:
	print("Sss")
	pass # Replace with function body.
