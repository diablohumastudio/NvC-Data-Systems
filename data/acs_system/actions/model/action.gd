class_name Action extends Resource

enum TYPES {LV_COMPLTD, ENEMY_KILLED, LV_COMPLTD_ALL_CANONS, BUYED_ALLY_LEVEL, TEST}

var type: TYPES
var payload: Payload

func _init(_type: TYPES, _payload: Payload) -> void:
	type = _type
	payload = _payload

class Payload extends Resource:
	pass

class PayLvCompl extends Payload:
	var level_id: Level.IDs
	
	func _init(_level_id: Level.IDs) -> void:
		level_id = _level_id

class PayEnemKilled extends Payload:
	var killed_enemies: int
	
	func _init(_killed_enemies: int) -> void:
		killed_enemies = _killed_enemies

class PayLvlComplAllCanons extends Payload:
	var level_id: Level.IDs
	var canons_alive: int

	func _init(_level_id: Level.IDs, _canons_alive: int) -> void:
		level_id = _level_id
		canons_alive = _canons_alive

class PayBuyedAllyLevel extends Payload:
	var ally_level_id: String
	var ally_id: Ally.IDs
	
	func _init(_ally_level_id: String, _ally_id: Ally.IDs) -> void:
		ally_level_id = _ally_level_id
		ally_id = _ally_id
