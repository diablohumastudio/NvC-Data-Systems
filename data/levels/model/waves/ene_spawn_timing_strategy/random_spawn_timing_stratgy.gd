class_name RandomSpawnTimingStrategy extends EneSpawnTimingStrategy

var min_wait_time: float
var max_wait_time: float

func get_spawning_wait_times(quantity: int) -> Array[float]:
	var times: Array[float]
	for ii in quantity - 1:
		times.append(randf_range(min_wait_time, max_wait_time))
	return times
