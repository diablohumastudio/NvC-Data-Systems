@tool
class_name EnemiesSpawnersGrid extends ButtonCellGrid

func _ready() -> void:
	CELL_PKSC = load("uid://cpt4e3qp1ti4")
	if !is_inside_tree(): return
	_set_cells()
