class_name GameOverPopup extends Control

@export var level : LevelData # Its exported for testing purposes

func _ready() -> void:
	if GSS.level: level = GSS.level

func _show():
	get_tree().paused = true
	AudioSystem.post_event(AK.EVENTS.SET_POPUP_FILTER)
	visible = true
	%AnimationPlayer.play("_appear")

func _hide():
	get_tree().paused = false
	AudioSystem.post_event(AK.EVENTS.RESET_POPUP_FILTER)
	visible = false

func _on_go_to_main_menu_button_pressed():
	var main_menu : PackedScene = load(GC.SCREENS_UIDS.MAIN_MENU)
	
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	await get_tree().create_timer(.5).timeout
	
	get_tree().paused = false
	SMS.change_scene(main_menu)

func _on_play_again_button_pressed():
	var game : PackedScene = load(GC.SCREENS_UIDS.GAME)
	
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	await get_tree().create_timer(.5).timeout
	
	get_tree().paused = false
	SMS.change_scene(game,{"level": level})
