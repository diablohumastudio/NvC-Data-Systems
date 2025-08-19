class_name CondLvCompl extends Condition

@export var level_id: Level.IDs

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD

func evaluate(action: Action): 
	if !action:
		push_error("Action MUST NOT be null when calling evaluate in object type CondLvCompl")
		print_stack()
		return
	if action.payload is not PayLvCompl:
		push_error("Action.payload MUST be of type PayLvCompl when calling evaluate in object type CondLvCompl")
		print_stack()
		return
	
	var payload: PayLvCompl = action.payload
	if level_id == payload.level_id:
		fullfilled.emit(self)
