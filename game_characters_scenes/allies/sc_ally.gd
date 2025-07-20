class_name ScAlly extends GameCharacter

var level: AllyLevel: set = _set_level
var ally: Ally
var hp: int

func _set_level(new_value: AllyLevel):
	level = new_value

func _ready() -> void:
	%AllyUpgradeMenu.ally = ally
	%AllyUpgradeMenu.level_changed.connect(on_ally_upgrade_menu_level_changed)
	set_name_and_level()

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level
	set_name_and_level()

func set_name_and_level():
	%AllyNameAndLevelLabel.text = "Type: " + ally.ally_name + "\n Level " + str(level.level_id)

func _on_show_upgrade_popup_btn_pressed() -> void:
	%AllyUpgradeMenu.visible = true
