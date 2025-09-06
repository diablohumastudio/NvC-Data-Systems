class_name GameOverPopup extends Control

@export var level : LevelData # Its exported for testing purposes

func _ready() -> void:
	if GSS.level: level = GSS.level
	GSS.enemy_reached_last_column.connect(on_gss_enemy_reached_last_column)
	appear()

func on_gss_enemy_reached_last_column():
	appear()

func appear():
	%AnimationPlayer.play("_appear")

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
