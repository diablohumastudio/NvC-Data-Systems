class_name AllyDetailsPopup extends Control

var ally: Ally : set = _set_ally

func _set_ally(new_value: Ally):
	ally = new_value
	if ally:
		_set_visuals()

func _set_visuals() -> void:
	%AllyName.text = ally.ally_name
	%AllyThumbnail.texture = ally.thumbnail
	display_levels()

func display_levels() -> void:
	for child in %AllylevelsPresContainer.get_children():
		child.queue_free()
	for level in ally.ud_ally.levels_conditions:
		var new_level_presenter: AllyLevelPresenter = load("res://screens/allies_market/ally_details_popup/ally_level_presenter/ally_level_presenter.tscn").instantiate()
		new_level_presenter.level = level
		%AllylevelsPresContainer.add_child(new_level_presenter)

func _on_close_btn_pressed() -> void:
	hide()
