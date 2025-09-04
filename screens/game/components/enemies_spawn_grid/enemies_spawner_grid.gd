@tool
class_name EnemiesSpawnersGrid extends ButtonCellGrid

var enemies_pkscs: Dictionary[EnemyScene.TYPES, PackedScene]

func _ready() -> void:
	CELL_PKSC = load("uid://cpt4e3qp1ti4")
	if !is_inside_tree(): return
	_set_cells()
	
	var level: LevelData = GSS.level
	var wave: WaveData = load("uid://dij34l0lxkdfr")
	load_enemies_from_wave(wave)
	spawn_wave(wave)

func spawn_waves():
	pass

func spawn_wave(wave: WaveData):
	var total_enemies_number: int = get_total_enemies_number_in_wave(wave)
	var spawn_wait_times: Array[float] = wave.timing_strategy.get_spawning_wait_times(total_enemies_number)
	var spawn_grid_positions: Array[Vector2] = wave.position_strategy.get_spawning_positions(total_enemies_number, self)
	var enemies: Array[EnemyScene] = get_enemies_from_wave(wave)
	for ii in total_enemies_number:
		var position: Vector2 = spawn_grid_positions[ii]
		var enemies_spawner: EnemiesSpawnerCell = get_cell_by_col_and_row(position.x, position.y)
		enemies_spawner.spawn_enemy(enemies[ii])
		if ii < spawn_wait_times.size(): 
			await get_tree().create_timer(spawn_wait_times[ii]).timeout

func get_total_enemies_number_in_wave(wave: WaveData) -> int:
	var total_enemies: int = 0
	for enemy_type in wave.enemies:
		total_enemies += wave.enemies[enemy_type]
	return total_enemies

func load_enemies_from_wave(wave: WaveData):
	for enemy_type: EnemyScene.TYPES in wave.enemies.keys():
		var enemy_scene_path: String = GC.ENEMIES_TYPES_UIDS[enemy_type]
		enemies_pkscs[enemy_type] = load(enemy_scene_path)

func get_enemies_from_wave(wave: WaveData):
	var enemies: Array[EnemyScene] = []
	for enemy_type: EnemyScene.TYPES in wave.enemies:
		for enemy_quantity in wave.enemies[enemy_type]:
			var new_enemy: EnemyScene
			new_enemy = enemies_pkscs[enemy_type].instantiate()
			enemies.append(new_enemy)
	return enemies
