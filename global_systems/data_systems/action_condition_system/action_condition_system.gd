extends Node

var conditions: Array[Condition] 
var state_changers: Array[StateChanger]

func _ready() -> void:
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
