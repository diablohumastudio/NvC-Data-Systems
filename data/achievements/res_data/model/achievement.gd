class_name Achievement extends Resource

enum IDs {achiv_compl_lv_2, achiv_compl_lv_2_and_2p, achiv_enem_kill_any_level_3, achiv_enem_kill_tot_5}

@export var id: IDs

@export var achievement_name: String
@export var description: String
@export var reward: int

@export var conditions: Array[Condition]

func get_saved_ud_achievement() -> UDAchievement:
	return UDS.get_ud_achievement_by_id(id)
