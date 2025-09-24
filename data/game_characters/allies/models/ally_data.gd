class_name AllyData extends GameCharacterData

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs #TODO El mismo que AllyLevel.level_id 

@export var ally_name: String
@export var description: String

@export var levels: Array[AllyLevelData]
@export var base_level: AllyLevelData 

func get_saved_ud_ally() -> UDAlly:
	return UDS.get_ud_ally_by_id(id)
