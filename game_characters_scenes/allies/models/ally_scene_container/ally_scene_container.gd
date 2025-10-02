class_name AllySceneContainer extends Control

var terrain_gri_cell_width: int
var ally: AllyData
var current_ally_scene: AllyScene
var acs: ActionConditionSystem
var in_game_buyed_levels: Array[AllyLevelData]

func _ready() -> void:
	acs = ActionConditionSystem.new("res://global_systems/data_systems/action_condition_system/conditions/data/in_game/", "res://global_systems/data_systems/action_condition_system/state_changers/data/in_game/")
	in_game_buyed_levels.append(ally.base_level)
	change_sc_ally(load(ally.base_level.scene_path).instantiate())
	%AllyUpgradePopUp.ally = ally
	%AllyUpgradePopUp.acs = acs
	%AllyUpgradePopUp.level_changed.connect(on_ally_upgrade_menu_level_changed)

func change_sc_ally(new_ally_scene: AllyScene):
	if has_node("AllyScene"):
		current_ally_scene.name = "OldScAlly"
		current_ally_scene.queue_free()
	new_ally_scene.name = "AllyScene"
	new_ally_scene.terrain_grid_cell_width = terrain_gri_cell_width
	new_ally_scene.pressed.connect(on_select_ally_btn_pressed)
	add_child(new_ally_scene)
	fix_hud_position_and_z()
	current_ally_scene = new_ally_scene

func fix_hud_position_and_z():
	var popup_position : Vector2 = %AllyUpgradePopUp.global_position
	%AllyUpgradePopUp.top_level = true
	%AllyUpgradePopUp.global_position = popup_position

func on_ally_upgrade_menu_level_changed(level: AllyLevelData):
	if ResourceLoader.exists(level.scene_path):
		change_sc_ally(load(level.scene_path).instantiate()) # TODO: load at ready of game_screen
	in_game_buyed_levels.append(level)
	get_tree().call_group(str(current_ally_scene), "set_levels", in_game_buyed_levels)
	#TODO set variables of ally based on in_game_buyed_levels

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state:
		queue_free()
	else:
		%AllyUpgradePopUp.show()
