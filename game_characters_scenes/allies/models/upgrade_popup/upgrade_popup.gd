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
		new_upgrade_to_level_btn.upgraded_to_level.connect(_on_upgrade_to_level_button_upgraded_to_level)
		%UpgradeToLevelBtnsContainer.add_child(new_upgrade_to_level_btn)

func _on_upgrade_to_level_button_upgraded_to_level(level: AllyLevel):
	for upgrade_to_lvl_btn in %UpgradeToLevelBtnsContainer.get_children() as Array[UpgradeToLevelButton]:
		printt(upgrade_to_lvl_btn.level.level_id, upgrade_to_lvl_btn.level.in_game_buyed, upgrade_to_lvl_btn.level.in_game_unlocked)
		upgrade_to_lvl_btn._undate_colors()
