class_name PayLvlComplAllCanons extends ActionPayload
var level_id: LevelData.IDs
var canons_alive: int

func _init(_level_id: LevelData.IDs, _canons_alive: int) -> void:
	level_id = _level_id
	canons_alive = _canons_alive
