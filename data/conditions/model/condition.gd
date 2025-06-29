class_name Condition extends Resource

@warning_ignore("unused_signal")
signal fullfilled(cond: Condition)

@export var id: String

@warning_ignore("unused_parameter")
func evaluate(action: Action):
	pass
