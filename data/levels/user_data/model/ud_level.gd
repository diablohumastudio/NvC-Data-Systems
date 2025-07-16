class_name UDLevel extends Resource

@export var id: Level.IDs

@export var completed: bool = false
@export var completed_all_canons: bool = false

@export var locked: bool = true
@export var unlocked_conditionis: Dictionary[Condition, bool] : set = _set_unlocked_condition

func _set_unlocked_condition(new_value: Dictionary[Condition, bool]) -> void:
	# Disconnect old signals to prevent memory leaks
	if unlocked_conditionis:
		for unlocked_condition in unlocked_conditionis:
			if unlocked_condition.fullfilled.is_connected(_on_unlocked_condition_fullfilled):
				unlocked_condition.fullfilled.disconnect(_on_unlocked_condition_fullfilled)
	
	unlocked_conditionis = new_value
	if !unlocked_conditionis: return
	
	# Connect new signals
	for unlocked_condition in unlocked_conditionis:
		if !unlocked_condition.fullfilled.is_connected(_on_unlocked_condition_fullfilled):
			unlocked_condition.fullfilled.connect(_on_unlocked_condition_fullfilled)

func _on_unlocked_condition_fullfilled(condition : Condition) -> void:
	unlocked_conditionis[condition] = true
	for unlocked_condition in unlocked_conditionis:
		if unlocked_conditionis[unlocked_condition] == false:
			return
	if locked:
		self.locked = false
