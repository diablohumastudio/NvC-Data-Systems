class_name AllyData extends GameCharacterData

enum IDs { BAYONET_SOLDIER = 101, 
			FAST_BAYONET_SOLDIER = 102, 
			LIGHT_MACHINE_GUNNER = 103,
			SHIELD_SOLDIER = 104,
			FARMER = 105,
			SNOWMAN = 106,
			IRON_CHEST = 201,
			WOODEN_CHEST = 202,
			AIRFIELD_TARGET = 203,
			BARRIER = 301,
			WOODEN_BARRIER = 302,
			LANDMINE = 401,
			GRENADE = 402,
			MOLOTOV_COCTAIL = 403
			}

@export var id: IDs

@export var ally_name: String
@export var description: String
@export var ally_selector_thumbnail: Texture2D 

@export var levels: Array[AllyLevelData]
@export var base_level: AllyLevelData 

func get_saved_ud_ally() -> UDAlly:
	return UDS.get_ud_ally_by_id(id)
