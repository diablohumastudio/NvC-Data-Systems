extends Node

var conditions: Array[Condition] 

func _ready() -> void:
	conditions = DataFilesLoader.get_conditions_from_res_files()

func _evaluate_conditions(action: Action):
	for cond in conditions:
		cond.evaluate(action)

func set_action(action: Action):
	_evaluate_conditions(action)
