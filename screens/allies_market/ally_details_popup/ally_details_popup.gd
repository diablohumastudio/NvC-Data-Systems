class_name AllyDetailsPopup extends AcceptDialog

var ally: Ally : set = _set_ally

func _set_ally(new_value: Ally) -> void:
	ally = new_value
	if ally:
		_update_visuals()

func _update_visuals() -> void:
	if !ally:
		return
		
	# Update basic info
	%AllyName.text = ally.ally_name
	%AllyDescription.text = ally.description
	if ally.thumbnail:
		%AllyThumbnail.texture = ally.thumbnail
	
	# Update level info
	%AllyLevel.text = "Level: " + str(ally.ud_ally.level)
	
	# Update buttons based on ally state
	_update_buttons()

func _update_buttons() -> void:
	if ally.ud_ally.locked:
		# Ally is locked - show buy button
		%BuyButton.visible = true
		%UpgradeButton.visible = false
		%PriceLabel.text = "Price: " + str(ally.price)
	else:
		# Ally is unlocked - check if can upgrade
		%BuyButton.visible = false
		
		var current_level = ally.ud_ally.level
		var max_level = ally.max_level
		
		if current_level >= max_level:
			# Already at max level - hide upgrade button
			%UpgradeButton.visible = false
			%PriceLabel.text = "Max Level Reached"
		else:
			# Can upgrade - show upgrade button
			%UpgradeButton.visible = true
			var next_level = current_level + 1
			%UpgradeButton.text = "Upgrade from lvl " + str(current_level) + " to lvl " + str(next_level)
			%PriceLabel.text = "Upgrade Price: " + str(ally.upgrade_price)

func _on_buy_button_pressed() -> void:
	if ally && ally.ud_ally.locked:
		# Trigger buy action
		ACS.set_action(Action.new(Action.TYPES.UNLOCK_ALLY, Action.PayUnlockAlly.new(ally.id)))
		# Update visuals after purchase
		_update_buttons()

func _on_upgrade_button_pressed() -> void:
	if ally && !ally.ud_ally.locked && ally.ud_ally.level < ally.max_level:
		# Trigger upgrade action
		ACS.set_action(Action.new(Action.TYPES.UPGRADE_ALLY, Action.PayUpgradeAlly.new(ally.id)))
		# Update visuals after upgrade
		_update_visuals()

func show_ally_details(target_ally: Ally) -> void:
	ally = target_ally
	popup_centered()
