class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export var id: Achievement.IDs

@export var is_achieved: bool = false
@export var porcentage_achieved: int = 0

@export var conditions: Array[Condition]: set = _set_conditions
@export var conditions_trac: Array = []

func _set_conditions(new_value: Array[Condition]):
	conditions = new_value
	if !conditions: return
	for condition in conditions:
		conditions_trac.append(false)
		condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	conditions_trac[conditions.find(condition)] = true
	for cond_tr in conditions_trac:
		if cond_tr == false:
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
