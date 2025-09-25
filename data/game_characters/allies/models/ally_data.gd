class_name AllyData extends GameCharacterData

enum IDs { BAYONETE_SOLDIER = 0, 
			CHEST = 100, 
			HAND = 200}

@export var id: IDs

@export var ally_name: String
@export var description: String
@export var ally_selector_thumbnail: Texture2D 

@export var levels: Array[AllyLevelData]
@export var base_level: AllyLevelData 

func get_saved_ud_ally() -> UDAlly:
	return UDS.get_ud_ally_by_id(id)
