class_name AllyData extends GameCharacterData

enum IDs { BYS = 101, 
			FBS = 102, 
			LMG = 103,
			SHS = 104,
			FAR = 105,
			SNM = 106,
			IRC = 201,
			WDC = 202,
			AFT = 203,
			BAR = 301,
			WDB = 302,
			LDM = 401,
			GRN = 402,
			MOL = 403
			}

@export var id: IDs

@export var ally_name: String
@export var description: String
@export var ally_selector_thumbnail: Texture2D 

@export var levels: Array[AllyLevelData]
@export var base_level: AllyLevelData 

func get_saved_ud_ally() -> UDAlly:
	return UDS.get_ud_ally_by_id(id)
