class_name AllySelectorCard extends VBoxContainer

signal selected

var ally: Ally

func _ready() -> void:
	if !ally: return
	%AllyName.text = ally.ally_name
	%AllySelCardBtn.texture_normal = ally.base_level.ally_selector_thumbnail
	%AllySelCardBtn.set_meta("ally", ally)

func _on_ally_sel_card_btn_toggled(toggled_on: bool) -> void:
	if toggled_on: modulate = Color.GREEN
	else: modulate = Color.WHITE
