class_name CondInGameAllyLevelBuyed extends Condition

@export var ally_level_id: String

func _init() -> void:
	type = Action.TYPES.IN_GAME_BUYED_ALLY_LEVEL

func evaluate(action: Action):
	var payload: Action.PayInGameBuyedAllyLevel = action.payload
	if ally_level_id == payload.ally_level_id:
		fullfilled.emit(self)
