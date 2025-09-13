class_name RandomSpawnGridPosStrategy extends EneSpawnPosStrategy

func get_spawning_positions(enemy_quantity: int, enemies_spawners_grid: EnemiesSpawnersGrid) -> Array[Vector2i]:
	var positions : Array[Vector2i] = []
	for ii in enemy_quantity:
		var column = select_random_grid_column(enemies_spawners_grid)
		var row = select_random_grid_row(enemies_spawners_grid)
		positions.append(Vector2i(column,row))
	return positions

func select_random_grid_column(enemy_spawners_grid: EnemiesSpawnersGrid) -> int:
	return randi_range(0, enemy_spawners_grid.columns - 1)

func select_random_grid_row(enemy_spawners_grid: EnemiesSpawnersGrid) -> int:
	return randi_range(0, enemy_spawners_grid.rows - 1)
