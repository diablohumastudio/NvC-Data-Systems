class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export var id: Achievement.IDs

@export var is_achieved: bool = false
@export var porcentage_achieved: int = 0

@export var conditions: Dictionary[Condition, bool]: set = _set_conditions

func _set_conditions(new_value: Dictionary[Condition, bool]):
	conditions = new_value
	if !conditions: return
	for key in conditions:
		print(key.id)
		key.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	conditions[condition] = true
	for key in conditions:
		if conditions[key] == false:
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
