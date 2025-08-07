class_name AlliesSelector extends MarginContainer

var ally_selector_card_pksc: PackedScene = preload("uid://d3ht2nmc2bh8o")

func _ready() -> void:
	_populate_cards()

func _populate_cards():
	for child in %CardsContainer.get_children():
		child.free()
	for ally in DataFilesLoader.get_allies_from_res_files() as Array[Ally]:
		var new_ally_selector_card: AllySelectorCard = ally_selector_card_pksc.instantiate()
		new_ally_selector_card.ally = ally
		%CardsContainer.add_child(new_ally_selector_card)
