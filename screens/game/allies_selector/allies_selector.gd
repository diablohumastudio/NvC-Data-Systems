class_name AlliesSelector extends MarginContainer

signal ally_selected(ally)

var ally_selector_card_pksc: PackedScene = preload("uid://d3ht2nmc2bh8o")
var ally_selector_button_group: ButtonGroup = preload("uid://tyopysg35h4n")

func time_block_card(ally: Ally):
	for card in %CardsContainer.get_children() as Array[AllySelectorCard]:
		if card.ally == ally:
			card.start_time_blocking()

func _ready() -> void:
	_populate_cards()
	ally_selector_button_group.pressed.connect(_on_ally_selector_button_group_changed)

func _populate_cards():
	for child in %CardsContainer.get_children():
		child.queue_free()
	for ally in DataFilesLoader.get_allies_from_res_files() as Array[Ally]:
		var new_ally_selector_card: AllySelectorCard = ally_selector_card_pksc.instantiate()
		new_ally_selector_card.ally = ally
		%CardsContainer.add_child(new_ally_selector_card)
	
func _on_ally_selector_button_group_changed(ally_sel_card_btn: TextureButton):
	var selected_ally: Ally = _get_ally_from_card_button(ally_sel_card_btn)
	if ally_sel_card_btn.button_pressed: 
		ally_selected.emit(selected_ally)
	else:
		ally_selected.emit(null)

func _get_ally_from_card_button(ally_sel_card_btn: TextureButton) -> Ally:
	if !ally_sel_card_btn.has_meta("ally"):
		push_error("Button has no 'ally' metadata. Wrong button added to group or button wasnt configured 'ally' metadata.")
		return null
	else:
		return (ally_sel_card_btn.get_meta("ally") as Ally)
