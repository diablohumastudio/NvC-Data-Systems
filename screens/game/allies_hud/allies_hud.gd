extends MarginContainer

func _ready() -> void:
	for child in %AlliesAdderContainer.get_children():
		child.queue_free()
	for ally in DataFilesLoader.get_allies_from_res_files():
		var new_ally_adder: AllyAdder = load("res://screens/game/allies_hud/ally_adder/ally_adder.tscn").instantiate()
		new_ally_adder.ally = ally
		%AlliesAdderContainer.add_child(new_ally_adder)
