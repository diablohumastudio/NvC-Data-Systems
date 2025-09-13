class_name LastColumnEnemyDetectors extends Area2D

signal enemy_reached_last_column

func _on_body_entered(body: Node2D) -> void:
	if body is EnemyScene:
		enemy_reached_last_column.emit()
