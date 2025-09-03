class_name EnemiesSpawnerCell extends Cell

signal enemy_spawned(enemy: EnemyScene)

func spawn_enemy(enemy: EnemyScene):
	add_child(enemy)
	enemy_spawned.emit(enemy)
