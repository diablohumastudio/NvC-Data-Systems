class_name SCUpgradeAlly extends StateChanger

func _init() -> void:
	type = Action.TYPES.UPGRADE_ALLY

func change_state(action: Action):
	var payload: Action.PayUpgradeAlly = action.payload
	var ally_id = payload.ally_id
	var upgraded_level = payload.ally_level

	for ud_ally in UDS.current_user_data.allies_inventory.ud_allies:
		if ud_ally.id == ally_id:
			ud_ally.unlocked_levels.append(upgraded_level)
