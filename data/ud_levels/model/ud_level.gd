class_name UDLevel extends Resource

@export var id: Level.IDs

@export var locked: bool = true
@export var completed: bool = false
@export var unlocked_conditions: Array[CondLvCompl] : set = _set_unlocked_condition
@export var unl_cond_tracking: Dictionary = {}
@export_storage var my_var : Dictionary = {}
@export var completed_condition: CondLvCompl : set = _set_completed_condition 

func _set_unlocked_condition(new_value: Array[CondLvCompl]) -> void:
	unlocked_conditions = new_value
	if !unlocked_conditions: return
	for unlocked_condition in unlocked_conditions:
		unl_cond_tracking.set(unlocked_condition.id, false)
		my_var.set(unlocked_condition.id, false)
		unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)

func _set_completed_condition(new_value: CondLvCompl) -> void:
	completed_condition = new_value
	if !completed_condition: return
	completed_condition.fullfilled.connect(_on_completed_condition_fullfilled)

func _on_unlocked_condition_fullfilled(_cond : CondLvCompl) -> void:
	unl_cond_tracking[_cond.id] = true
	for key in unl_cond_tracking:
		if unl_cond_tracking[key] == false:
			return
	self.locked = false

func _on_completed_condition_fullfilled(_cond: Condition):
	self.completed = true
