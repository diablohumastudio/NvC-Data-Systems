class_name PausedGamePopup extends Control

@export var level : LevelData
var _saved_settings = UDS.current_user_data.settings

var is_shown: bool

func _ready():
	if GSS.level: level = GSS.level

func _show():
	get_tree().paused = true
	AudioSystem.post_event(AK.EVENTS.SET_POPUP_FILTER)
	visible = true
	%AnimationPlayer.play("appear")

func _hide():
	AudioSystem.post_event(AK.EVENTS.RESET_POPUP_FILTER)
	get_tree().paused = false
	%AnimationPlayer.play("dissapear")
	await %AnimationPlayer.animation_finished
	self.visible = false

func _on_resume_game_button_pressed() -> void:
	_hide()

func _on_retry_level_button_pressed() -> void:
	var game : PackedScene = load(GC.SCREENS_UIDS.GAME)

	await get_tree().create_timer(.5).timeout

	get_tree().paused = false
	SMS.change_scene(game,{"level": level})

func _on_go_to_main_menu_button_pressed():
	var main_menu : PackedScene = load(GC.SCREENS_UIDS.MAIN_MENU)

	await get_tree().create_timer(.5).timeout

	get_tree().paused = false
	SMS.change_scene(main_menu)
