class_name AllyLevelData extends GameCharacterLevelData

signal in_game_just_unlocked
signal in_game_just_buyed

@export_category("ID")
@export var id: String 
@export var ally_id: AllyData.IDs

@export_category("Market Config")
@export var unlockd_by_default: bool = false
@export var buyed_by_default: bool = false
@export var unlock_conditions: Array[Condition]
@export var market_price: int

@export_category("In-Game Config")
@export var ally_level_thumbnail: Texture2D
@export_file var scene_path: String = "res://game_characters_scenes/" 
@export var in_game_price: int
@export var in_game_unlock_conditions: Array[Condition] 
var in_game_unlocked: bool = false
var in_game_buyed: bool = false: set = _set_in_game_buyed
var in_game_fullfilled_conditions : Array[String] = []

func _set_in_game_buyed(new_value: bool):
	in_game_buyed = new_value
	in_game_just_buyed.emit()

func get_saved_ud_ally_level() -> UDAllyLevel:
	if UDS == null: return null
	return UDS.get_ud_ally_level_by_id_in_ally(id, ally_id)

func set_in_game_unlock_conditions_by_acs_instance(acs: ActionConditionSystem):
	#disconect from previous setted value
	if in_game_unlock_conditions:
		for condition in in_game_unlock_conditions as Array[Condition]:
			if condition.fullfilled.is_connected(_on_in_game_unlock_condition_fullfilled):
				condition.fullfilled.disconnect(_on_in_game_unlock_condition_fullfilled)
	
	var new_conditions_array: Array[Condition]

	for condition in in_game_unlock_conditions:
		var new_condition: Condition = acs.get_condition_by_id(condition.id)
		new_conditions_array.append(new_condition)
	in_game_unlock_conditions = new_conditions_array

	if !in_game_unlock_conditions: return

	for condition in in_game_unlock_conditions as Array[Condition]:
		if !condition.fullfilled.is_connected(_on_in_game_unlock_condition_fullfilled):
			condition.fullfilled.connect(_on_in_game_unlock_condition_fullfilled)

func _on_in_game_unlock_condition_fullfilled(_condition: Condition):
	in_game_fullfilled_conditions.append(_condition.id)
	_check_is_unlocked()

func _check_is_unlocked():
	for condition in in_game_unlock_conditions:
		if !in_game_fullfilled_conditions.has(condition.id):
			return
	if !in_game_unlocked:
		in_game_unlocked = true
		in_game_just_unlocked.emit()
