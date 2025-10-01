class_name UDLevel extends Resource

@export_storage var id: LevelData.IDs

@export_storage var completed: bool = false
@export_storage var completed_all_canons: bool = false

@export_storage var locked: bool = true

@export_storage var conditions: Array[Condition] : set = _set_conditions
@export_storage var fullfilled_conditions: Array[String] = []

func _set_conditions(new_value: Array[Condition]):
	#disconect from previous setted value
	if conditions:
		for condition in conditions as Array[Condition]:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	for condition in new_value:
		conditions.append(ACS.get_condition_by_id(condition.id))

	if !conditions: return
	
	for condition in conditions as Array[Condition]:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(_condition: Condition):
	fullfilled_conditions.append(_condition.id)
	_check_is_unlocked()

func _check_is_unlocked():
	for condition in conditions:
		print("fulfilled conditions has:", fullfilled_conditions.has(condition.id))
		if !fullfilled_conditions.has(condition.id):
			return
	if locked:
		locked = false
