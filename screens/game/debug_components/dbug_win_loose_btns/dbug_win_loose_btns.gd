class_name DBugWinBtn extends HBoxContainer

func _on_win_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD_ALL_CANONS, PayLvlComplAllCanons.new(GSS.level.id, GSS.canons_alive)))
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, PayLvCompl.new(GSS.level.id)))
	GSS.game_just_won.emit()
	UDS.save_user_data_to_disk()

func _on_loose_btn_pressed() -> void:
	GSS.enemy_reached_last_column.emit()
