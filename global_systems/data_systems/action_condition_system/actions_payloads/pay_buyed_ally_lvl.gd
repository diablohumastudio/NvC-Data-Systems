class_name PayBuyedAllyLevel extends ActionPayload
var ally_level_id: String
var ally_id: AllyData.IDs

func _init(_ally_level_id: String, _ally_id: AllyData.IDs) -> void:
	ally_level_id = _ally_level_id
	ally_id = _ally_id
