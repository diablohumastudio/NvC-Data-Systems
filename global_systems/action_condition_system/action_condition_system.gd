extends Node

var conditions: Array[Condition] 

func _ready() -> void:
	conditions = DataFilesLoader.get_conditions_from_res_files()

func set_action(action: Action):
	_evaluate_conditions(action)

func _evaluate_conditions(action: Action):
	for cond in conditions:
		if cond.type == action.type:
			cond.evaluate(action)
