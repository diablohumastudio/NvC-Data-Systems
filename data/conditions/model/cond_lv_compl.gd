class_name CondLvCompl extends Condition

@export var level_id: Level.IDs

func evaluate(action: Action):
	var payload: Action.PayLvCompl = action.payload as Action.PayLvCompl
	if level_id == payload.level_id:
		fullfilled.emit(self)
