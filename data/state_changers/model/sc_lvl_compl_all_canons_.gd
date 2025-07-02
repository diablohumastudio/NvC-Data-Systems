class_name SCLvComplAllCanons extends StateChanger

func _init() -> void:
	type = Action.TYPES.LV_COMPLTD_ALL_CANONS

func change_state(action: Action):
	var payload: Action.PayLvlComplAllCanons = action.payload
	var lvl_id = payload.level_id
	if payload.canons_alive != GC.TOTAL_NUMBER_OF_CANONS: return
	for ud_level in UDS.current_user_data.progress.ud_levels:
		if ud_level.id == lvl_id:
			ud_level.completed_all_canons = true
