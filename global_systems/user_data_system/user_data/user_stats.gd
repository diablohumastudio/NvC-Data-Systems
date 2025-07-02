class_name UserStats extends Resource

signal total_enemies_killed_changed

@export var total_enemies_killed: int = 0 : set = _set_total_enemies_killed

func _set_total_enemies_killed(new_value: int):
	total_enemies_killed = new_value
	total_enemies_killed_changed.emit()
