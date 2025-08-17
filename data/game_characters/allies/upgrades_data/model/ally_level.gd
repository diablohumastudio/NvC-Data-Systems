class_name AllyLevel extends GameCharacterLevel

signal in_game_just_unlocked

@export_category("ID")
@export var level_id: String
@export var ally_id: Ally.IDs

@export_category("Market Config")
@export var unlockd_by_default: bool = false
@export var buyed_by_default: bool = false
@export var unlock_conditions: Array[Condition]
@export var market_price: int

@export_category("In-Game Config")
@export var ally_selector_thumbnail: Texture2D
@export var scene: PackedScene
@export var in_game_price: int
@export var in_game_unlock_conditions: Array[Condition] = []: set = _set_in_game_unlock_conditions
var in_game_unlocked: bool = false
var in_game_buyed: bool = false
var in_game_fullfilled_conditions : Array[String] = []

func get_saved_ud_ally_level() -> UDAllyLevel:
	return UDS.get_ud_ally_level_by_id_in_ally(level_id, ally_id)

func _set_in_game_unlock_conditions(new_value: Array[Condition]):
	#disconect from previous setted value
	if in_game_unlock_conditions:
		for condition in in_game_unlock_conditions as Array[Condition]:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	in_game_unlock_conditions = new_value
	
	if !in_game_unlock_conditions: return

	for condition in in_game_unlock_conditions as Array[Condition]:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(_condition: Condition):
	in_game_fullfilled_conditions.append(_condition.id)
	_check_is_unlocked()

func _check_is_unlocked():
	for condition in in_game_unlock_conditions:
		if !in_game_fullfilled_conditions.has(condition.id):
			return
	if !in_game_unlocked:
		in_game_unlocked = true
		in_game_just_unlocked.emit()
