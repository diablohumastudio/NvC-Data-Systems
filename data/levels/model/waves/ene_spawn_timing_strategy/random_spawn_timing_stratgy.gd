class_name RandomSpawnTimingStrategy extends EneSpawnTimingStrategy

@export var min_wait_time: float
@export var max_wait_time: float

func get_spawning_wait_times(enemy_quantity: int) -> Array[float]:
	var times: Array[float]
	for ii in enemy_quantity - 1:
		times.append(randf_range(min_wait_time, max_wait_time))
	return times
