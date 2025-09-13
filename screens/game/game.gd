class_name Game extends Control

@export var level: LevelData : set = _set_level

func _set_level(new_value: LevelData) -> void:
	level = new_value
	GSS.level = level
	GSS.reset_values()

func _ready() -> void:
	connect_animation_triggers()
	%HUD.modulate = Color.TRANSPARENT
	_initialize_background()
	_show_preview_process()

func connect_animation_triggers():
	var animation_triggers = get_tree().get_nodes_in_group("animation_trigger")
	for anim_trigger: AnimationTrigger in animation_triggers:
		anim_trigger.animation_triggered.connect(_on_animation_trigger_animation_triggered)

func _on_animation_trigger_animation_triggered(anim_type: AnimationTrigger.ANIMATION_TYPES):
	var animatable_elements  = get_tree().get_nodes_in_group("animatable_elements")
	for ani_element: AnimatableElement in animatable_elements:
		ani_element.play_animation(anim_type)

func _initialize_background():
	SMS.change_scene(load(level.background_path), {}, $BackgroundScene, true)
	$BackgroundScene.position.x = level.background_position

func _show_preview_process():
	get_tree().paused = true

	%AnimationPlayer.play("appear_HUD")
	await %AnimationPlayer.animation_finished
	await %EnemiesSpawnersGrid.spawn_preview_wave()
	await %CameraManager.show_enemies_preview()
	%GameStartCountdown.start_count_down()
	await %GameStartCountdown.played_defend_sound
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_STALINGRAD_SUMMER_GAME)
	await %CameraManager.show_black_borders()
	await %GameStartCountdown.start_countdown_finished
	get_tree().paused = false

func _on_last_column_enemy_detectors_enemy_reached_last_column() -> void:
	game_lost()
	
func _on_dbug_win_btn_game_lost_btn_pressed() -> void:
	game_lost()

func game_lost():
	%GameOverPopup._show()
	
func _on_dbug_win_btn_game_win_btn_pressed() -> void:
	game_won()

func game_won():
	%GameWonPopup._show()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MAIN_MENU))

func _on_go_back_to_test_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))

func _on_pause_btn_pressed() -> void:
	%PausedGamePopup._show()
