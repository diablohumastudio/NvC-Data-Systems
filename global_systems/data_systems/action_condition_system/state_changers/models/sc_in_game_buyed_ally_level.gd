class_name SCInGameBuyedAllyLevel extends StateChanger

func _init() -> void:
	type = Action.TYPES.IN_GAME_BUYED_ALLY_LEVEL

func change_state(action: Action):
	var payload: PayInGameBuyedAllyLevel = action.payload
	var level: AllyLevel = payload.level
	level.in_game_buyed = true
