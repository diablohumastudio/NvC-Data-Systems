@tool
class_name ButtonCellGrid extends CenterContainer

@export var columns: int : set = _set_columns
@export var rows: int : set = _set_rows

@export var cell_width_px: int : set = _set_cell_width_px
@export var cell_heigth_px: int : set = _set_cell_heigth_px

var CELL_PKSC: PackedScene

func _set_columns(new_value: int):
	columns = new_value
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

func _ready() -> void:
	CELL_PKSC = load("uid://bubd7o2pf31bi")
	if !is_inside_tree(): return
	_set_cells()

func _set_cells():
	%CellsContainer.columns = columns
	_delete_all_cells()
	_create_cells()

func _delete_all_cells():
	for child in %CellsContainer.get_children():
		child.free()
		pass

func _create_cells():
	for row in rows:
		for column in columns:
			var new_cell: Cell = CELL_PKSC.instantiate()
			new_cell.name = "Cell_" + str(column) + "_" + str(row)
			new_cell.column = column
			new_cell.row = row
			new_cell.custom_minimum_size = Vector2(cell_width_px, cell_heigth_px)
			new_cell.size =  Vector2(cell_width_px, cell_heigth_px)
			%CellsContainer.add_child(new_cell)

func get_cells() -> Array[Cell]:
	var cells: Array[Cell]
	for cell: Cell in %CellsContainer:
		cells.append(cell)
	return cells
