class_name EneSpawnTimingStrategy extends Resource

func get_spawning_wait_times(quantity: int) -> Array[float]:
	push_error("MUST USE INHERITED SPAWNING STRATEGY THAT OVERRIDES get_spawning_times() FUNCTION")
	return []
