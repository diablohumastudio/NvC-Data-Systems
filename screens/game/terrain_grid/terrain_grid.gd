@tool
class_name TerrainGrid extends CenterContainer

@export var columms: int : set = _set_columns
@export var rows: int : set = _set_rows

@export var cell_width_px: int : set = _set_cell_width_px
@export var cell_heigth_px: int : set = _set_cell_heigth_px

var cell_pksc: PackedScene = load("res://screens/game/terrain_grid/cell/cell.tscn")

func _set_columns(new_value: int):
	columms = new_value
	if Engine.is_editor_hint():
		_set_visuals()

func _set_rows(new_value: int):
	rows = new_value
	if Engine.is_editor_hint():
		_set_visuals()

func _set_cell_width_px(new_value: int):
	cell_width_px = new_value
	if Engine.is_editor_hint():
		_set_visuals()

func _set_cell_heigth_px(new_value: int):
	cell_heigth_px = new_value
	if Engine.is_editor_hint():
		_set_visuals()

func _set_visuals():
	var cells_number = rows * columms
	%CellsContainer.columns = columms
	for child in %CellsContainer.get_children():
		child.queue_free()
	for ii in cells_number:
		var new_cell: Cell = cell_pksc.instantiate()
		new_cell.custom_minimum_size = Vector2(cell_width_px, cell_heigth_px)
		new_cell.size =  Vector2(cell_width_px, cell_heigth_px)
		%CellsContainer.add_child(new_cell)

func _ready() -> void:
	_set_visuals()
