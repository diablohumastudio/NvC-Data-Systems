class_name UDLevel extends Resource

@export var id: Level.IDs

@export var locked: bool = true
@export var completed: bool = false
@export var completed_all_canons: bool = false

@export var unlocker_levels_ids: Array[Level.IDs] = [] : set = _set_unlocker_levels_ids
@export var unlocker_levels_id_traker: Dictionary[Level.IDs, bool]

func _set_unlocker_levels_ids(new_value: Array[Level.IDs]) -> void:
	unlocker_levels_ids = new_value
	for unlocker_level_id in unlocker_levels_ids:
		unlocker_levels_id_traker.set(unlocker_level_id, true)
#@export var unlocked_conditions: Array[CondLvCompl] : set = _set_unlocked_condition
#@export var unl_cond_tracke: Array = []

#func _set_unlocked_condition(new_value: Array[CondLvCompl]) -> void:
	#unlocked_conditions = new_value
	#if !unlocked_conditions: return
	#for unlocked_condition in unlocked_conditions:
		#unl_cond_tracke.append(false)
		#unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)
#
#func _on_unlocked_condition_fullfilled(_cond : CondLvCompl) -> void:
	#unl_cond_tracke[unlocked_conditions.find(_cond)] = true
	#for cond_tr in unl_cond_tracke:
		#if cond_tr == false:
			#return
	#if locked:
		#self.locked = false
