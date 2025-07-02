class_name CondLvCompl extends Condition

@export var level_id: Level.IDs

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD

func evaluate(action: Action):
	var payload: Action.PayLvCompl = action.payload
	if level_id == payload.level_id:
		fullfilled.emit(self)
