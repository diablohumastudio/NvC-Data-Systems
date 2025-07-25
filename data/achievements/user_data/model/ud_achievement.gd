class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export_storage var id: Achievement.IDs

@export_storage var is_achieved: bool = false
@export_storage var porcentage_achieved: int = 0

@export_storage var conditions: Array[Condition]: set = _set_conditions

func _set_conditions(new_value: Array[Condition]):
	# Disconnect old signals to prevent memory leaks
	if conditions:
		for condition in conditions:
			if condition.fullfilled.is_connected(_on_condition_fullfilled):
				condition.fullfilled.disconnect(_on_condition_fullfilled)
	
	conditions = new_value
	if !conditions: return

	for condition in conditions as Array[Condition]: 
		condition = ACS.get_saved_user_condition_by_id(condition.id)

	# Connect new signals
	for condition in conditions:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	_check_is_achieved()

func _check_is_achieved():
	for condition in conditions:
		if !condition.is_fullfilled:
			return
	if !is_achieved:
		is_achieved = true
		achieved.emit(id)
