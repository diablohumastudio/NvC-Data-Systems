class_name Game extends Control

@export var level: LevelData : set = _set_level

func _set_level(new_value: LevelData) -> void:
	level = new_value
	GSS.level = level
	GSS.reset_values()

func _ready() -> void:
	SMS.change_scene(load(level.background_path), {}, $BackgroundScene, true)
	$BackgroundScene.position.x = level.background_position
	%GameStartCountdown.start_count_down()
	GSS.enemy_reached_last_column.connect(on_enemy_reach_last_column)

func on_enemy_reach_last_column():
	disable_process.call_deferred()
	%GameOverPopup.show()

func disable_process(): 
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MAIN_MENU))

func _on_go_back_to_test_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))

func _on_pause_btn_pressed() -> void:
	%PausedGamePopup._show()
