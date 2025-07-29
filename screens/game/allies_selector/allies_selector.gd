class_name AlliesSelector extends MarginContainer

signal ally_selected(ally)

var ally_selector_card_pksc: PackedScene = load("res://screens/game/allies_selector/ally_selector_card/ally_selector_card.tscn")

func _ready() -> void:
	for child in %CardsContainer.get_children():
		child.queue_free()
	for ally in DataFilesLoader.get_allies_from_res_files() as Array[Ally]:
		var new_ally_selector_card: AllySelectorCard = ally_selector_card_pksc.instantiate()
		new_ally_selector_card.ally = ally
		new_ally_selector_card.selected.connect(func(): ally_selected.emit(ally))
		%CardsContainer.add_child(new_ally_selector_card)
