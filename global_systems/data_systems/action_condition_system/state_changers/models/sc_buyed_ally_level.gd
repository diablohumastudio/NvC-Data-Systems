class_name SCBuyedAllyLevel extends StateChanger

func _init() -> void:
	type = Action.TYPES.BUYED_ALLY_LEVEL

func change_state(action: Action):
	var payload: PayBuyedAllyLevel = action.payload
	var ally_id = payload.ally_id
	var ally_level_id = payload.ally_level_id

	var ud_ally_level: UDAllyLevel = UDS.get_ud_ally_level_by_id_in_ally(ally_level_id,ally_id)
	ud_ally_level.buyed = true
