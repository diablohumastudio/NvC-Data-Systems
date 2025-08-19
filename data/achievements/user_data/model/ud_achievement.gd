class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export_storage var id: Achievement.IDs

@export_storage var is_achieved: bool = false
@export_storage var porcentage_achieved: int = 0

@export_storage var conditions: Array[Condition]: set = _set_conditions
@export_storage var fullfilled_conditions: Array[String] = []

func _set_conditions(new_value: Array[Condition]):
	#disconect from previous setted value
	if conditions:
		for condition in conditions:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	for condition in new_value:
		conditions.append(ACS.get_condition_by_id(condition.id))
	if !conditions: return

	for condition in conditions:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(_condition: Condition):
	fullfilled_conditions.append(_condition.id)
	_check_is_achieved()

func _check_is_achieved():
	for condition in conditions:
		if !fullfilled_conditions.has(condition.id):
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
