class_name SCKilledEnemy extends StateChanger

func _init() -> void:
	type = Action.TYPES.ENEMY_KILLED

func change_state(_action: Action):
	UDS.current_user_data.stats.total_enemies_killed += 1
