extends Control

func _ready() -> void:
	var ally: Ally = load("uid://dnxrv0styygjo")
	for level in ally.levels as Array[AllyLevel]:
		printt("from ready in test",level, level.level_id, level.in_game_unlock_conditions)
	%AllyUpgradePopUp.ally = ally
	%AllyUpgradePopUp._set_level_buttons()
	%AllyUpgradePopUp2.ally = ally
	%AllyUpgradePopUp2._set_level_buttons()

func _on_print_levels_pressed() -> void:
	print("--------------------------------popup1")
	for levelbtn in %AllyUpgradePopUp.get_node("%UpgradeToLevelBtnsContainer").get_children() as Array[UpgradeToLevelButton]:
		var level = levelbtn.level
		printt("from test scene levele in pop1:", level, level.in_game_unlocked, level.in_game_buyed, level.level_id )
	print("--------------------------------popup2")
	for levelbtn in %AllyUpgradePopUp2.get_node("%UpgradeToLevelBtnsContainer").get_children() as Array[UpgradeToLevelButton]:
		var level = levelbtn.level
		printt("from test scene levele in pop2:", level, level.in_game_unlocked, level.in_game_buyed, level.level_id )
