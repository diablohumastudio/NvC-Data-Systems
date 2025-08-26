class_name AllyDetailsPopup extends Control

var ally: AllyData : set = _set_ally

func _set_ally(new_value: AllyData):
	ally = new_value
	if ally:
		_set_visuals()

func _set_visuals() -> void:
	%AllyName.text = ally.ally_name
	%AllyThumbnail.texture = ally.base_level.ally_selector_thumbnail
	display_levels()

func display_levels() -> void:
	for child in %AllylevelsPresContainer.get_children():
		child.queue_free()
	for ally_level in ally.levels:
		var new_level_presenter: AllyLevelPresenter = load("uid://dr58mra5vkhob").instantiate()
		new_level_presenter.ally_level = ally_level
		if !new_level_presenter.level_buyed.is_connected(update_all_level_presenters):
			new_level_presenter.level_buyed.connect(update_all_level_presenters)
		%AllylevelsPresContainer.add_child(new_level_presenter)

func update_all_level_presenters():
	for child in %AllylevelsPresContainer.get_children():
		(child as AllyLevelPresenter)._update_visuals()

func _on_close_btn_pressed() -> void:
	hide()
