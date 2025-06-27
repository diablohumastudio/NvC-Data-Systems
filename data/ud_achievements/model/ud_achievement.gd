class_name UDAchievement extends Resource

signal achieved(id: Achievement.IDs)

@export var id: Achievement.IDs

@export_storage var is_achieved: bool = false
@export_storage var porcentage_achieved: int = 0

@export var conditions: Array[Condition]: set = _set_conditions
@export_storage var conditions_traker : Dictionary

func _set_conditions(new_value: Array[Condition]):
	conditions = new_value
	if !conditions: return
	for condition in conditions:
		conditions_traker.set(condition.id, false)
		condition.fullfilled.connect(_on_condition_fullfilled)
	printt("setter",self, self.id ,conditions_traker)

func _on_condition_fullfilled(condition: Condition):
	conditions_traker.set(condition.id, true)
	printt(self, self.id, conditions_traker)
	for key in conditions_traker:
		if conditions_traker[key] == false:
			return
	is_achieved = true
	achieved.emit(id)
