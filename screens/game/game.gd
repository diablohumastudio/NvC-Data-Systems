extends Control

var level: Level : set = _set_level

func _set_level(new_value: Level) -> void:
	level = new_value
	%LevelNamePresenter.text = level.level_name

func _on_win_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, Action.PayLvCompl.new(level.id)))

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)

func _on_kill_enemy_btn_pressed() -> void:
	var total_enemies_killed: int = UDS.get_property(UDS.PROPERTIES.ENEMIES_KILLED)
	total_enemies_killed += 1
	ACS.set_action(Action.new(Action.TYPES.ENEMY_KILLED, Action.PayEnemKilled.new(total_enemies_killed)))
