class_name UDAchievement extends Resource

@export var id: Achievement.IDs

@export_storage var is_achieved: bool = false
@export_storage var porcentage_achieved: int = 0

@export var conditions: Condition: set = _set_conditions

func _set_conditions(new_value: Condition):
	conditions = new_value
	if !conditions: return
	conditions.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(_cond: Condition):
	print()
	is_achieved = true
