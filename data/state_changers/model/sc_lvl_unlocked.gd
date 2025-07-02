class_name SCLvUnlocked extends StateChanger

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD

func change_state(action: Action):
	var payload: Action.PayLvCompl = action.payload
	var lvl_id = payload.level_id

	for ud_level in UDS.current_user_data.progress.ud_levels as Array[UDLevel]:
		for key in ud_level.unlocker_levels_ids as Dictionary[Level.IDs, bool]:
			if key == lvl_id:
				ud_level.unlocker_levels_ids.set(key, false)
		for key in ud_level.unlocker_levels_ids as Dictionary[Level.IDs, bool]:
			if ud_level.unlocker_levels_ids[key] == true:
				return
		ud_level.locked = false
