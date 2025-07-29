class_name Ally extends Resource

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs

@export var ally_name: String
@export var description: String

@export var price: int

@export var levels: Array[AllyLevel]
@export var base_level: AllyLevel

func get_saved_ud_ally() -> UDAlly:
	return UDS.get_ud_ally_by_id(id)
