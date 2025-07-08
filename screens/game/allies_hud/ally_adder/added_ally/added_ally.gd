class_name AddedAlly extends HBoxContainer

var ally: Ally: set = _set_ally
var level: int = 1

func _set_ally(new_value:Ally):
	ally = new_value
	_update_label()
	_update_upgrade_button()

func _update_upgrade_button():
	# Enable button only if ally is unlocked from market and in-game level can be upgraded
	# Can't upgrade beyond the level purchased in market
	%UpgradeBtn.disabled = ally.ud_ally.locked or level >= ally.ud_ally.level

func _on_upgrade_btn_pressed() -> void:
	if ally && !ally.ud_ally.locked && level < ally.ud_ally.level:
		# Upgrade in-game ally level with in-game money
		level += 1
		_update_upgrade_button()
		_update_label()

func _update_label() -> void:
	%Label.text = ally.ally_name + " in level: " + str(level)
