class_name LastColumnEnemyDetectors extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is EnemyScene:
		GSS.enemy_reached_last_column.emit()
