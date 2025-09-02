class_name WaveData extends Node

@export var enemies: Dictionary[EnemyScene.TYPES, int]
@export var position_strategy: EneSpawnPosStrategy
@export var timing_strategy: EneSpawnTimingStrategy

func get_total_enemies_number() -> int:
	var total_enemies: int = 0
	for enemy_quantity in enemies:
		total_enemies =+ enemy_quantity
	return total_enemies

func get_spawning_wait_times() -> Array[float]:
	return timing_strategy.get_spawning_wait_times(get_total_enemies_number())

func get_spawning_positions() -> Array[Vector2]:
	return position_strategy.get_spawning_positions(get_total_enemies_number())
