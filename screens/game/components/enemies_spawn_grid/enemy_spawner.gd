class_name EnemiesSpawner extends RefCounted

signal enemy_spawned(enemy: EnemyScene)

func spawn_enemy(enemy: EnemyScene, enemy_parent: Node):
	enemy_parent.add_child(enemy)
	enemy_spawned.emit(enemy)
