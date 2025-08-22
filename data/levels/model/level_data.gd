class_name LevelData extends Resource

enum IDs {Level1, Level2, Level2p, Level3, LevelEx, LevelEx2, Level4}

@export var id: IDs
@export var level_name: String

@export var conditions: Array[Condition]
@export var unlockd_by_default: bool = false

func get_saved_ud_level() -> UDLevel:
	return UDS.get_ud_level_by_id(id)
