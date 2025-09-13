class_name EneSpawnPosStrategy extends Resource

func get_spawning_positions(_enemy_quantity: int, _enemies_spawners_grid: EnemiesSpawnersGrid) -> Array[Vector2i]:
	push_error("MUST USE INHERITED SPAWNING STRATEGY THAT OVERRIDES get_spawning_positions() FUNCTION")
	return []
