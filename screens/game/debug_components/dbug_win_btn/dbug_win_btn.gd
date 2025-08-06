class_name DBugWinBtn extends Button

signal game_won

var level: Level

func _on_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD_ALL_CANONS, Action.PayLvlComplAllCanons.new(level.id, GSS.canons_alive)))
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, Action.PayLvCompl.new(level.id)))
	game_won.emit()
