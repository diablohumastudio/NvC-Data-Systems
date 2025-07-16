class_name Ally extends Resource

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs

@export var ally_name: String
@export var description: String
@export var thumbnail: Texture2D

@export var price: int

@export var ud_ally: UDAlly : set = _set_ud_ally

@export var scene: PackedScene

func _set_ud_ally(new_value:UDAlly) -> void:
	ud_ally = new_value
	for saved_ud_ally in UDS.current_user_data.allies_inventory.ud_allies:
		if saved_ud_ally.id == ud_ally.id:
			ud_ally = saved_ud_ally
