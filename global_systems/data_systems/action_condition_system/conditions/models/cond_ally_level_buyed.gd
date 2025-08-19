class_name CondAllyLevelBuyed extends Condition

@export var ally_level_id: String

func _init() -> void:
	type = Action.TYPES.BUYED_ALLY_LEVEL

func evaluate(action: Action):
	var payload: PayBuyedAllyLevel = action.payload
	if ally_level_id == payload.ally_level_id:
		fullfilled.emit(self)
