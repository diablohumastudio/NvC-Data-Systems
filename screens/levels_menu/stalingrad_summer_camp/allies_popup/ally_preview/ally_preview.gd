class_name AllyPreview extends Control

signal upgrade_btn_pressed

func display_ally_scene(ally_scene:PackedScene) -> void:
	if ally_scene:
		for child in %AllyContainer.get_children():
			child.queue_free()
		
		var instantiated_ally_scene : CharacterBody2D = ally_scene.instantiate()
		%AllyContainer.add_child(instantiated_ally_scene)
		instantiated_ally_scene.position = %ScenePosition.position
	else:
		push_error("ally packed scene to display is null")

func set_upgrade_price_label(upgrade_price : int) -> void:
	%UpgradePriceLabel.text = str(upgrade_price)

func _on_upgrade_button_pressed() -> void:
	%UpgradePriceLabel.text = "Buyed!"
	upgrade_btn_pressed.emit()
