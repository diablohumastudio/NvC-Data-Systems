class_name UDLevel extends Resource

@export var id: Level.IDs

@export var locked: bool = true
@export var completed: bool = false
@export var completed_all_canons: bool = false
@export var unlocked_conditions: Array[CondLvCompl] : set = _set_unlocked_condition
@export var unl_cond_tracke: Array = []
@export var completed_condition: CondLvCompl : set = _set_completed_condition 

func _set_unlocked_condition(new_value: Array[CondLvCompl]) -> void:
	unlocked_conditions = new_value
	if !unlocked_conditions: return
	for unlocked_condition in unlocked_conditions:
		unl_cond_tracke.append(false)
		unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)

func _set_completed_condition(new_value: CondLvCompl) -> void:
	completed_condition = new_value
	if !completed_condition: return
	completed_condition.fullfilled.connect(_on_completed_condition_fullfilled)

func _on_unlocked_condition_fullfilled(_cond : CondLvCompl) -> void:
	unl_cond_tracke[unlocked_conditions.find(_cond)] = true
	for cond_tr in unl_cond_tracke:
		if cond_tr == false:
			return
	if locked:
		self.locked = false

func _on_completed_condition_fullfilled(_cond: Condition):
	if !self.completed:
		self.completed = true
