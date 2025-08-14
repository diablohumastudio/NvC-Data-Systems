class_name AllyUpgradeMenu extends Control

signal level_changed(level)

const UPGRADE_TO_LEVEL_BTN_PKSC: PackedScene = preload("uid://mwls1togvm3o")

var ally: Ally 

func _ready() -> void:
	_set_level_buttons()

func _set_level_buttons():
	if !ally: return
	for level in ally.levels:
		var new_upgrade_to_level_btn: UpgradeToLevelButton = UPGRADE_TO_LEVEL_BTN_PKSC.instantiate()
		new_upgrade_to_level_btn.level = level
		%UpgradeToLevelBtnsContainer.add_child(new_upgrade_to_level_btn)
