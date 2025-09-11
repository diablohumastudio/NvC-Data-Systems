@tool
class_name TerrainGrid extends ButtonCellGrid

func _ready() -> void:
	CELL_PKSC = load("uid://ddno47pjc4k1h")
	if !is_inside_tree(): return
	_set_cells()
