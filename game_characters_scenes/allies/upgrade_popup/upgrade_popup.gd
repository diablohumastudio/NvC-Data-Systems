class_name AllyUpgradeMenu extends Control

signal level_changed(level)

var ally: Ally: set = _set_ally 

func _set_ally(new_value: Ally):
	ally = new_value
	_set_level_buttons()

func _set_level_buttons():
	for level in ally.ud_ally.levels_conditions:
		var new_upgrade_to_level_btn: Button = Button.new()
		new_upgrade_to_level_btn.text = "Upgrade to level: " + level.level_id
		new_upgrade_to_level_btn.set("theme_override_font_sizes/font_size", 35)
		new_upgrade_to_level_btn.pressed.connect(_on_upgrade_to_level_btn_presse.bind(level))
		%UpgradeToLevelBtnsContainer.add_child(new_upgrade_to_level_btn)

func _on_upgrade_to_level_btn_presse(level: AllyLevel):
	level_changed.emit(level)
