class_name Cannons extends VBoxContainer

var playable_rows : Array[int] = [0,1,2,3,4]

func _ready() -> void:
	_set_cannons_on_playable_rows()

func _set_cannons_on_playable_rows():
	for ii in get_children().size():
		var cannon: Cannon = get_child(ii)
		if !playable_rows.has(ii):
			cannon.visible = false
