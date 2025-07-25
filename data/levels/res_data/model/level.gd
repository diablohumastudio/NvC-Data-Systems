class_name Level extends Resource

enum IDs {Level1, Level2, Level2p, Level3, LevelEx, LevelEx2, Level4}

@export var id: IDs
@export var level_name: String

@export var conditions: Array[Condition]
@export var unlockd_by_default: bool = false

func get_ud_level() -> UDLevel:
	var new_ud_level : UDLevel
	if !UDS : return
	for saved_ud_lv in UDS.current_user_data.progress.ud_levels:
		if saved_ud_lv.id == id:
			new_ud_level = saved_ud_lv

	return new_ud_level
