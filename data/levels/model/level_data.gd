class_name LevelData extends Resource

enum IDs {Level1, Level2, Level2p, Level3, LevelEx, LevelEx2, Level4}

@export var id: IDs
@export var level_name: String

@export var conditions: Array[Condition]
@export var unlockd_by_default: bool = false

@export_file var background_path: String = "res://data/levels/data/"
@export_enum("left:0", "center:-1920", "right:-3840") var background_position:int

@export var waves: Array[WaveData] = []

func get_saved_ud_level() -> UDLevel:
	return UDS.get_ud_level_by_id(id)
