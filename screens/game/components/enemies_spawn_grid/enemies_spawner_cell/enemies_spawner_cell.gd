class_name EnemiesSpawnerCell extends Cell

signal enemy_spawned(enemy: EnemyScene)

func _ready() -> void:
	if !Engine.is_editor_hint(): self_modulate = Color.TRANSPARENT

func spawn_enemy(enemy: EnemyScene):
	add_child(enemy)
	enemy_spawned.emit(enemy)
