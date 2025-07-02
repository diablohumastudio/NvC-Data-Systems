class_name SCLvCompl extends StateChanger

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD

func change_state(action: Action):
	var payload: Action.PayLvCompl = action.payload
	var lvl_id = payload.level_id

	for ud_level in UDS.current_user_data.progress.ud_levels:
		if ud_level.id == lvl_id:
			ud_level.completed = true
