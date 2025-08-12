class_name ScAllyContainer extends Node2D

var ally: Ally
var level: AllyLevel: set = _set_level

func _set_level(new_value: AllyLevel):
	level = new_value 
	var new_sc_ally = change_ally_scene(level.scene.instantiate())
	fix_ally_upgrade_menu_position(new_sc_ally)
	($ScAlly/AllyHUD/AllyUpgradeMenu as AllyUpgradeMenu).level_changed.connect(on_ally_upgrade_menu_level_changed)
	($ScAlly/AllyHUD/SelectAllyBtn as TextureButton).pressed.connect(on_select_ally_btn_pressed)

func change_ally_scene(new_sc_ally: ScAlly) -> ScAlly:
	$ScAlly.name = "OldScAlly"
	$OldScAlly.queue_free()
	new_sc_ally.name = "ScAlly"
	add_child(new_sc_ally)
	return new_sc_ally

func fix_ally_upgrade_menu_position(sc_ally: ScAlly):
	var ally_upgrade_meny: AllyUpgradeMenu = sc_ally.get_node("%AllyUpgradeMenu")
	ally_upgrade_meny.ally = ally #TODO: replace, new menus are not configurable but instantiated
	var previous_pos = ally_upgrade_meny.global_position
	ally_upgrade_meny.top_level = true
	ally_upgrade_meny.global_position = previous_pos
	
	
	

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state: 
		self.queue_free()
		GSS.removing_ally_state = false
	else: $ScAlly/AllyHUD/AllyUpgradeMenu.visible = true
