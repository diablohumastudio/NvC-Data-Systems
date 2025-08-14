class_name ScAllyContainer extends Control

var ally: Ally
var current_ally_scene: ScAlly

func _ready() -> void:
	change_sc_ally(ally.base_level.scene.instantiate())

func change_sc_ally(new_ally_scene: ScAlly):
	if has_node("ScAlly"):
		current_ally_scene.name = "OldScAlly"
		disconnect_sc_ally_hud(current_ally_scene)
		current_ally_scene.queue_free()
	new_ally_scene.name = "ScAlly"
	(new_ally_scene.get_node("AllyHUD/AllyUpgradeMenu") as AllyUpgradeMenu).ally = ally
	connect_sc_ally_hud(new_ally_scene)
	add_child(new_ally_scene)
	fix_hud_position_and_z(new_ally_scene)
	current_ally_scene = new_ally_scene

func fix_hud_position_and_z(ally_scene: ScAlly):
	var HUD = (ally_scene.get_node("AllyHUD") as Control)
	var hud_position : Vector2 = HUD.global_position
	HUD.top_level = true
	HUD.global_position = hud_position

func disconnect_sc_ally_hud(ally_scene: ScAlly):
	if (ally_scene.get_node("AllyHUD/AllyUpgradeMenu") as AllyUpgradeMenu).level_changed.is_connected(on_ally_upgrade_menu_level_changed):
		(ally_scene.get_node("AllyHUD/AllyUpgradeMenu") as AllyUpgradeMenu).level_changed.disconnect(on_ally_upgrade_menu_level_changed)
	if (ally_scene.get_node("AllyHUD/SelectAllyBtn") as TextureButton).pressed.is_connected(on_select_ally_btn_pressed):
		(ally_scene.get_node("AllyHUD/SelectAllyBtn") as TextureButton).pressed.disconnect(on_select_ally_btn_pressed)

func connect_sc_ally_hud(ally_scene: ScAlly):
	(ally_scene.get_node("AllyHUD/AllyUpgradeMenu") as AllyUpgradeMenu).level_changed.connect(on_ally_upgrade_menu_level_changed)
	(ally_scene.get_node("AllyHUD/SelectAllyBtn") as TextureButton).pressed.connect(on_select_ally_btn_pressed)

func on_ally_upgrade_menu_level_changed(level: AllyLevel):
	change_sc_ally(level.scene.instantiate())

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state:
		queue_free()
	else:
		current_ally_scene.get_node("AllyHUD/AllyUpgradeMenu").show()
