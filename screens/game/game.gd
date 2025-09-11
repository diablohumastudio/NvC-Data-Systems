class_name Game extends Control

@export var level: LevelData : set = _set_level

func _set_level(new_value: LevelData) -> void:
	level = new_value
	GSS.level = level
	GSS.reset_values()

func _ready() -> void:
	%HUD.modulate = Color.TRANSPARENT
	_initialize_background()
	_show_preview_process()
	GSS.enemy_reached_last_column.connect(on_enemy_reach_last_column)

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

func on_enemy_reach_last_column():
	%GameOverPopup.show()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MAIN_MENU))

func _on_go_back_to_test_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))

func _on_pause_btn_pressed() -> void:
	%PausedGamePopup._show()
