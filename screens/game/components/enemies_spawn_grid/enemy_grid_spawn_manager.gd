class_name EnemyGridSpawnManager extends Node

@export var enemies_spawners_grid: EnemiesSpawnersGrid : set = _set_enemies_spawners_grid

var enemies_pkscs: Dictionary[EnemyScene.TYPES, PackedScene]
var waves: Array[WaveData]
var enemies_spawners: Array[EnemiesSpawner]

func start_spawning():
	pass

func spawn_wave(wave: WaveData):
	var total_enemies_number: int = wave.get_total_enemies()
	var spawn_wait_times: Array[float] = wave.timing_strategy.get_spawning_wait_times(total_enemies_number)
	var spawn_grid_positions: Array[Vector2] = wave.position_strategy.get_spawning_positions(total_enemies_number)
	load_enemies_from_wave(wave)
	var enemies: Array[EnemyScene] = get_enemies_from_wave(wave)

func load_enemies_from_wave(wave: WaveData):
	for enemy_type: EnemyScene.TYPES in wave.enemies.keys():
		var enemy_scene_path: String = GC.ENEMIES_TYPES_UIDS[enemy_type]
		enemies_pkscs[enemy_type] = load(enemy_scene_path)

func get_enemies_from_wave(wave: WaveData):
	var enemies: Array[EnemyScene]
	for enemy_type: EnemyScene.TYPES in wave.enemies.keys():
		var new_enemy: EnemyScene
		new_enemy = enemies_pkscs[enemy_type].instantiate()
		enemies.append(new_enemy)
	return enemies

func _set_enemies_spawners_grid(new_value: EnemiesSpawnersGrid):
	enemies_spawners_grid = new_value
	for cell: EnemiesSpawnerCell in enemies_spawners_grid.get_cells():
		enemies_spawners.append(cell.enemies_spawner)

func on_enemy_spawner_enemy_spawned(enemy: EnemyScene):
	print("enemy_spawned", enemy)
