class_name EnemiesSpawnerCell extends Cell

func _spawn_enemy(enemy: EnemyScene):
	add_child(enemy)
