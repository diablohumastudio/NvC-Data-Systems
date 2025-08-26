class_name DBugWinBtn extends Button

func _on_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD_ALL_CANONS, PayLvlComplAllCanons.new(GSS.level.id, GSS.canons_alive)))
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, PayLvCompl.new(GSS.level.id)))
	GSS.game_just_won.emit()
