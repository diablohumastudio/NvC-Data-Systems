extends Node

static var conditions: Array[Condition]
static var state_changers: Array[StateChanger]

static func get_conditions_from_res_files() -> Array[Condition]:
	if conditions.is_empty():
		conditions = DataFilesLoader.load_conditions_from_disk()
	return conditions
	
static func get_state_changer_from_res_files() -> Array[StateChanger]:
	if state_changers.is_empty():
		state_changers = DataFilesLoader.load_state_changers_from_disk()
	return state_changers
	
func _init() -> void:
	conditions = DataFilesLoader.get_conditions_from_res_files()
	state_changers = DataFilesLoader.get_state_changer_from_res_files()

func set_action(action: Action):
	_call_state_changers(action)
	_evaluate_conditions(action)

func _call_state_changers(action: Action):
	for sc in state_changers:
		if sc.type == action.type:
			sc.change_state.call(action)

func _evaluate_conditions(action: Action):
	for cond in conditions:
		if cond.type == action.type:
			cond.evaluate(action)
