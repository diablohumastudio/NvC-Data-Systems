@tool
class_name MarketAllyPresenter extends VBoxContainer

signal ally_details_requested(ally: Ally)

@export var ally: Ally : set = _set_ally

func _set_ally(new_value: Ally) -> void:
	ally = new_value
	set_visuals()

func set_visuals() -> void:
	if ally.thumbnail:
		%AllyThumbnail.texture = ally.thumbnail
	%AllyName.text = ally.ally_name

func _on_details_btn_pressed() -> void:
	ally_details_requested.emit(ally)
