class_name UDAllyLevel extends Resource

@export_storage var id: String
@export_storage var ally_id: Ally.IDs

@export_storage var unlocked: bool = false
@export_storage var buyed: bool = false

@export_storage var conditions: Array[Condition] : set = _set_conditions
@export_storage var fullfilled_conditions: Array[String] = []

func _set_conditions(new_value: Array[Condition]):
	#disconect from previous setted value
	if conditions:
		for condition in conditions as Array[Condition]:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	conditions = new_value
	if !conditions: return

	for condition in conditions as Array[Condition]:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(_condition: Condition):
	fullfilled_conditions.append(_condition.id)
	_check_is_unlocked()

func _check_is_unlocked():
	for condition in conditions:
		if !fullfilled_conditions.has(condition.id):
			return
	if !unlocked:
		unlocked = true
