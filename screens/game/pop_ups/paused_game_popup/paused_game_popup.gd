class_name PausedGamePopup extends Control

signal cancel_input_received
signal start_key_input_received

@export var level : LevelData
var _saved_settings = UDS.current_user_data.settings

func _ready():
	if GSS.level: level = GSS.level
	appear()

func _hide_popup():
	AudioSystem.post_event(AK.EVENTS.RESET_POPUP_FILTER)
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	%ResumePlayer.play("continue_pressed")
	await %ResumePlayer.animation_finished
	get_tree().paused = false
	%AnimationPlayer.play("dissapear")
	await %AnimationPlayer.animation_finished
	self.visible = false
	
func appear():
	AudioSystem.post_event(AK.EVENTS.SET_POPUP_FILTER)
	%AnimationPlayer.play("appear")

func _on_resume_game_button_pressed() -> void:
	pass

func _on_go_to_main_menu_button_pressed():
	var main_menu : PackedScene = load(GC.SCREENS_UIDS.MAIN_MENU)
	
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	await get_tree().create_timer(.5).timeout
	
	get_tree().paused = false
	SMS.change_scene(main_menu)

func _on_retry_level_button_pressed() -> void:
	var game : PackedScene = load(GC.SCREENS_UIDS.GAME)
	
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	await get_tree().create_timer(.5).timeout
	
	get_tree().paused = false
	SMS.change_scene(game,{"level": level})
