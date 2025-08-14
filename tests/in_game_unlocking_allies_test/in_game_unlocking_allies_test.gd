extends Control

func _ready() -> void:
	var ally: Ally = load("uid://dnxrv0styygjo")
	%AllyUpgradePopUp.ally = ally
	%AllyUpgradePopUp._set_level_buttons()
	%AllyUpgradePopUp2.ally = ally
	%AllyUpgradePopUp2._set_level_buttons()
