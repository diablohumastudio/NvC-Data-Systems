class_name ScAlly extends GameCharacter

var level: String
var ally: Ally

func _ready() -> void:
	%AllyUpgradeMenu.ally = ally
	%AllyUpgradeMenu.level_changed.connect(on_ally_upgrade_menu_level_changed)
	set_name_and_level()

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level.level_id
	set_name_and_level()

func set_name_and_level():
	%AllyNameAndLevelLabel.text = "Ally of type:\n" + ally.ally_name + "\n is in Level " + str(level)

func _on_show_upgrade_popup_btn_pressed() -> void:
	%AllyUpgradeMenu.visible = true
