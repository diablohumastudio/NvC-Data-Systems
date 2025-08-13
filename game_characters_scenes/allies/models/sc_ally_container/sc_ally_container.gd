class_name ScAllyContainer extends Node2D

var ally: Ally
var level: AllyLevel: set = _set_level
var group_name: String
var levels: Array[AllyLevel]

func _set_level(new_value: AllyLevel):
	level = new_value 
	var new_sc_ally = level.scene.instantiate()
	await $ScAlly.change_ally_scene(new_sc_ally)
	group_name = str(new_sc_ally)
	fix_ally_upgrade_menu_position(new_sc_ally)
	await get_tree().process_frame
	($ScAlly/AllyHUD/AllyUpgradeMenu as AllyUpgradeMenu).level_changed.connect(on_ally_upgrade_menu_level_changed)
	($ScAlly/AllyHUD/SelectAllyBtn as TextureButton).pressed.connect(on_select_ally_btn_pressed)
	if has_node("$ScAlly/AllyHUD/Button") and has_node("$ScAlly/AllyHUD/Button2") and has_node("$ScAlly/AllyHUD/Button3"):
		($ScAlly/AllyHUD/Button as Button).pressed.connect(_on_test_btn_1_pressed)
		($ScAlly/AllyHUD/Button2 as Button).pressed.connect(_on_test_btn_2_pressed)
		($ScAlly/AllyHUD/Button3 as Button).pressed.connect(_on_test_btn_3_pressed)

func change_ally_scene(new_sc_ally: ScAlly):
	await $ScAlly.change_ally_scene(new_sc_ally)


func fix_ally_upgrade_menu_position(sc_ally: ScAlly):
	var ally_upgrade_meny: AllyUpgradeMenu = sc_ally.get_node("%AllyUpgradeMenu")
	ally_upgrade_meny.ally = ally #TODO: replace, new menus are not configurable but instantiated
	var previous_pos = ally_upgrade_meny.global_position
	ally_upgrade_meny.top_level = true
	ally_upgrade_meny.global_position = previous_pos
	
	
	

func _on_test_btn_1_pressed():
	var example_level: AllyLevel = load("res://data/game_characters/allies/upgrades_data/data/chest/base_chest_lvl.tres")
	levels.append(example_level)

func _on_test_btn_2_pressed():
	levels = []

func _on_test_btn_3_pressed():
	get_tree().call_group(group_name, "_on_ally_btn_pressed", levels)
	
func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state: 
		self.queue_free()
		GSS.removing_ally_state = false
	else: $ScAlly/AllyHUD/AllyUpgradeMenu.visible = true
