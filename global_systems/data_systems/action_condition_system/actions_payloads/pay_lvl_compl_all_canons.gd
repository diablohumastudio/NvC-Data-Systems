class_name PayLvlComplAllCanons extends ActionPayload
var level_id: Level.IDs
var canons_alive: int

func _init(_level_id: Level.IDs, _canons_alive: int) -> void:
	level_id = _level_id
	canons_alive = _canons_alive
