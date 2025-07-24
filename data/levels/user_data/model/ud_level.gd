class_name UDLevel extends Resource

@export var id: Level.IDs

@export var completed: bool = false
@export var completed_all_canons: bool = false

@export var locked: bool = true

@export var conditions: Array[Condition]: set = _set_conditions
@export var fullfilled_conditions_ids: Array[String]

func _set_conditions(new_value: Array[Condition]):
	if conditions:
		for condition in conditions as Array[Condition]:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	conditions = new_value
	if !conditions: return
	
	for condition in conditions as Array[Condition]:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	if !fullfilled_conditions_ids.has(condition.id):
		fullfilled_conditions_ids.append(condition.id)
	_check_is_unlocked()

func _check_is_unlocked():
	for _condition in conditions:
		if !fullfilled_conditions_ids.has(_condition.id):
			return
	if locked:
		locked = false
