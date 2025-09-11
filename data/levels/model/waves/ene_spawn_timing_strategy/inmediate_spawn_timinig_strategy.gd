class_name InmediateSpawnTimingStrategy extends EneSpawnTimingStrategy

func get_spawning_wait_times(enemy_quantity: int) -> Array[float]:
	var times: Array[float]
	for ii in enemy_quantity - 1:
		times.append(0)
	return times
