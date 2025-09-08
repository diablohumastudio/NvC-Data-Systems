class_name GameWonPopup extends Control

@export var level : LevelData

func _ready():
	if GSS.level: level = GSS.level
	GSS.game_just_won.connect(_show)

func _show():
	get_tree().paused = true
	AudioSystem.post_event(AK.EVENTS.SET_POPUP_FILTER)
	visible = true
	%AnimationPlayer.play("_appear")

func _hide():
	AudioSystem.post_event(AK.EVENTS.RESET_POPUP_FILTER)
	get_tree().paused = false
	self.visible = false

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

func _on_continue_button_pressed() -> void:
	pass # Replace with function body.
