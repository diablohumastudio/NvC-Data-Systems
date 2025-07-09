class_name SCUnlockAlly extends StateChanger

func _init() -> void:
	type = Action.TYPES.UNLOCK_ALLY

func change_state(action: Action):
	var payload: Action.PayUnlockAlly = action.payload
	var ally_id = payload.ally_id

	for ud_ally in UDS.current_user_data.allies_inventory.ud_allies:
		if ud_ally.id == ally_id:
			ud_ally.locked = false
