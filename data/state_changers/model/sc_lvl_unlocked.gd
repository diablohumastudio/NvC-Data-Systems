class_name SCLvUnlocked extends StateChanger

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD

func change_state(action: Action):
	var payload: Action.PayLvCompl = action.payload
	var lvl_id = payload.level_id

	for ud_level in UDS.current_user_data.progress.ud_levels as Array[UDLevel]:
		for unlocker_level_id in ud_level.unlocker_levels_ids as Array[Level.IDs]:
			if unlocker_level_id == lvl_id:
				ud_level.unlocker_levels_id_traker.set(unlocker_level_id, false)
		for unlocker_level_id in ud_level.unlocker_levels_ids as Array[Level.IDs]:
			if ud_level.unlocker_levels_id_traker[unlocker_level_id] == true:
				return
		ud_level.locked = false
