class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export var id: Achievement.IDs

@export var is_achieved: bool = false
@export var porcentage_achieved: int = 0

@export var conditions: Dictionary[Condition, bool]: set = _set_conditions

func _set_conditions(new_value: Dictionary[Condition, bool]):
	conditions = new_value
	if !conditions: return
	for condition in conditions:
		print(condition.id)
		condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	conditions[condition] = true
	for cond in conditions:
		if conditions[cond] == false:
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
