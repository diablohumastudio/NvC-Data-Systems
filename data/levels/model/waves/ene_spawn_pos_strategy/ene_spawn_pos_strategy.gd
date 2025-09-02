class_name EneSpawnPosStrategy extends Resource

func get_spawning_positions(quantity: int) -> Array[Vector2]:
	push_error("MUST USE INHERITED SPAWNING STRATEGY THAT OVERRIDES get_spawning_positions() FUNCTION")
	return []
