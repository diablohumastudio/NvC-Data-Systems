class_name Action extends Resource

enum TYPES {LV_COMPLTD, ENEMY_KILLED, LV_COMPLTD_ALL_CANONS, BUYED_ALLY_LEVEL, TEST, IN_GAME_BUYED_ALLY_LEVEL}

var type: TYPES
var payload: ActionPayload

func _init(_type: TYPES, _payload: ActionPayload) -> void:
	type = _type
	payload = _payload
