class_name RandomSpawnGridPosStrategy extends EneSpawnPosStrategy

var enemies_spawner_grid: EnemiesSpawnersGrid

func get_spawning_positions(enemy_quantity: int) -> Array[Vector2]:
	return get_spawning_positions_in_grid(enemy_quantity, enemies_spawner_grid)

func get_spawning_positions_in_grid(enemy_quantity: int, enemy_spawners_grid: EnemiesSpawnersGrid) -> Array[Vector2]:
	var positions : Array[Vector2] = []
	for ii in enemy_quantity:
		var column = select_random_grid_column(enemies_spawner_grid)
		var row = select_random_grid_row(enemies_spawner_grid)
		positions.append(Vector2(column,row))
	return positions

func select_random_grid_column(enemy_spawners_grid: EnemiesSpawnersGrid) -> int:
	return randi_range(0, enemy_spawners_grid.columns)

func select_random_grid_row(enemy_spawners_grid: EnemiesSpawnersGrid) -> int:
	return randi_range(0, enemy_spawners_grid.rows)
