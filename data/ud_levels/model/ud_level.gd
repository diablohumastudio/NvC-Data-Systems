class_name UDLevel extends Resource

@export var id: Level.IDs

@export var locked: bool = true
@export var completed: bool = false
@export var completed_all_canons: bool = false

@export var unlocked_conditions: Dictionary[Condition, bool] : set = _set_unlocked_condition

func _set_unlocked_condition(new_value: Dictionary[Condition, bool]) -> void:
	unlocked_conditions = new_value
	if !unlocked_conditions: return
	for unlocked_condition in unlocked_conditions:
		unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)

func _on_unlocked_condition_fullfilled(condition : Condition) -> void:
	unlocked_conditions[condition] = true
	for unlocked_condition in unlocked_conditions:
		if unlocked_conditions[unlocked_condition] == false:
			return
	if locked:
		self.locked = false
