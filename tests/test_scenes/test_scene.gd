extends Control

@export var ud_ally: UDAlly
var fast_chest_level_1: AllyLevel 
var cond_lvl_compl_2: Condition

const FILE_PATH: String = "user://test_ud_ally.tres"

func _ready() -> void:
	fast_chest_level_1 = load("res://data/game_characters/allies/upgrades_data/data/chest/fast_chest_lvl_1.tres")
	cond_lvl_compl_2 = load("res://data/acs_system/conditions/data/cond_lv_compl_lv_2.tres")

func _on_save_btn_pressed() -> void:
	var result : Error = ResourceSaver.save(ud_ally, FILE_PATH)
	assert(result == OK)

func _on_load_btn_pressed() -> void:
	ud_ally = load(FILE_PATH)

func _on_change_internal_bool_btn_pressed() -> void:
	ud_ally.levels[fast_chest_level_1][cond_lvl_compl_2] = true

func _on_print_internal_bool_btn_pressed() -> void:
	for level in ud_ally.levels:
		var conditions = ud_ally.levels[level]
		for condition in conditions:
			printt(level.level_id, condition.id, conditions[condition])

func _on_emit_action_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, Action.PayLvCompl.new(Level.IDs.Level2)))
