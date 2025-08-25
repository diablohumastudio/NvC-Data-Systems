@tool
class_name TerrainGrid extends CenterContainer

@export var columms: int : set = _set_columns
@export var rows: int : set = _set_rows

@export var cell_width_px: int : set = _set_cell_width_px
@export var cell_heigth_px: int : set = _set_cell_heigth_px

const CELL_PKSC: PackedScene = preload("uid://bubd7o2pf31bi")

func _set_columns(new_value: int):
	columms = new_value
	if Engine.is_editor_hint() and is_inside_tree():
		_set_cells()

func _set_rows(new_value: int):
	rows = new_value
	if Engine.is_editor_hint() and is_inside_tree():
		_set_cells()

func _set_cell_width_px(new_value: int):
	cell_width_px = new_value
	if Engine.is_editor_hint() and is_inside_tree():
		_set_cells()

func _set_cell_heigth_px(new_value: int):
	cell_heigth_px = new_value
	if Engine.is_editor_hint() and is_inside_tree():
		_set_cells()

func _set_cells():
	%CellsContainer.columns = columms
	for child in %CellsContainer.get_children():
		child.free()
		pass
	for row in rows:
		for column in columms:
			var new_cell: Cell = CELL_PKSC.instantiate()
			new_cell.name = "Cell_" + str(column) + "_" + str(row)
			new_cell.custom_minimum_size = Vector2(cell_width_px, cell_heigth_px)
			new_cell.size =  Vector2(cell_width_px, cell_heigth_px)
			%CellsContainer.add_child(new_cell)

func _ready() -> void:
	if !is_inside_tree(): return
	_set_cells()
