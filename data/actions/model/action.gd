class_name Action extends Resource

enum TYPES {LV_COMPLTD}

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
