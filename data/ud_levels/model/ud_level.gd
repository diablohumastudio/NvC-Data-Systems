class_name UDLevel extends Resource

@export var id: String 

@export var locked: bool = true
@export var completed: bool = false
@export var unlocked_condition: CondLvCompl : set = _set_unlocked_condition
@export var completed_condition: CondLvCompl : set = _set_completed_condition 

func _set_unlocked_condition(new_value: CondLvCompl) -> void:
	unlocked_condition = new_value
	if !unlocked_condition: return
	unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)

func _set_completed_condition(new_value: CondLvCompl) -> void:
	completed_condition = new_value
	if !completed_condition: return
	completed_condition.fullfilled.connect(_on_completed_condition_fullfilled)

func _on_unlocked_condition_fullfilled(_cond : CondLvCompl) -> void:
	self.locked = false

func _on_completed_condition_fullfilled(_cond: Condition):
	self.completed = true
