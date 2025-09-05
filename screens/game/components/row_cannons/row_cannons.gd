class_name RowCannons extends VBoxContainer

signal row_cannon_used(row_cannon_index:int)

var playable_rows : Array[int] = [1,2,3,4,5]

func _ready() -> void:
	for ii in get_children().size():
		var cannon: RowCannon = get_child(ii)
		if !playable_rows.has(ii):
			cannon.is_active = false

func display_all_row_cannons():
	for row_cannon: RowCannon in get_children():
		row_cannon.is_active = true
