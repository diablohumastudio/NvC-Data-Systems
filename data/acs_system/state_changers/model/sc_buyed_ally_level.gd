class_name SCBuyedAllyLevel extends StateChanger

func _init() -> void:
	type = Action.TYPES.BUYED_ALLY_LEVEL

func change_state(action: Action):
	var payload: Action.PayBuyedAllyLevel = action.payload
	var ally_id = payload.ally_id
	var ally_level_id = payload.ally_level_id

	for ud_ally in UDS.current_user_data.allies_inventory.ud_allies:
		if ud_ally.id == ally_id:
			var is_ally_level_buyed = ud_ally.buyed_levels.has(ally_level_id)
			if !is_ally_level_buyed:
				ud_ally.buyed_levels.append(ally_level_id)
