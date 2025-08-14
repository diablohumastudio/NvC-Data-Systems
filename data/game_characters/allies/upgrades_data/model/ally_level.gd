class_name AllyLevel extends GameCharacterLevel

@export_category("ID")
@export var level_id: String
@export var ally_id: Ally.IDs

@export_category("Market Config")
@export var unlockd_by_default: bool = false
@export var buyed_by_default: bool = false
@export var unlock_conditions: Array[Condition]
@export var market_price: int

@export_category("In-Game Config")
@export var ally_selector_thumbnail: Texture2D
@export var scene: PackedScene
@export var in_game_price: int
@export var in_game_unlocked_conditions: Array[Condition]

func get_saved_ud_ally_level() -> UDAllyLevel:
	return UDS.get_ud_ally_level_by_id_in_ally(level_id, ally_id)
