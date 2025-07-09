class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export var id: Achievement.IDs

@export var is_achieved: bool = false
@export var porcentage_achieved: int = 0

@export var conditions: Dictionary[Condition, bool]: set = _set_conditions

func _set_conditions(new_value: Dictionary[Condition, bool]):
	# Disconnect old signals to prevent memory leaks
	if conditions:
		for condition in conditions:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	conditions = new_value
	if !conditions: return
	
	# Connect new signals
	for condition in conditions:
		print(condition.id)
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	conditions[condition] = true
	for cond in conditions:
		if conditions[cond] == false:
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
