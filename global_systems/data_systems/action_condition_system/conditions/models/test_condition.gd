class_name CondTest extends Condition

func _init() -> void:
	type = Action.TYPES.TEST

func evaluate(_action: Action): 
	fullfilled.emit(self)
