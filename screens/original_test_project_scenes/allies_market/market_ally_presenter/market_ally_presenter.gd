@tool
class_name MarketAllyPresenter extends VBoxContainer

signal ally_details_requested(ally: AllyData)

@export var ally: AllyData : set = _set_ally

func _set_ally(new_value: AllyData) -> void:
	ally = new_value
	set_visuals()

func set_visuals() -> void:
	if ally.base_level.ally_selector_thumbnail:
		%AllyThumbnail.texture = ally.base_level.ally_selector_thumbnail
	%AllyName.text = ally.ally_name

func _on_details_btn_pressed() -> void:
	ally_details_requested.emit(ally)
