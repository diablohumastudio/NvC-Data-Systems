class_name AllySelectorCard extends VBoxContainer

signal selected

var ally: Ally

func _ready() -> void:
	if !ally: return
	%AllyName.text = ally.ally_name
	%AllySelCardthumbnailBtn.texture_normal = ally.base_level.ally_selector_thumbnail

func _on_ally_sel_cardthumbnail_btn_pressed() -> void:
	selected.emit()
