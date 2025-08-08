extends Node

signal _ally_just_placed(ally: Ally)
signal _game_just_won

signal _removing_ally_state_changed(state: bool)

var level: Level
var canons_alive: int
var enemies_killed: int
var ally_to_place: Ally
var removing_ally_state: bool: 
	set(new_value):
		removing_ally_state = new_value
		_removing_ally_state_changed.emit(removing_ally_state)

func reset_values():
	canons_alive = GC.TOTAL_NUMBER_OF_CANONS
	enemies_killed = 0
	ally_to_place = null
	removing_ally_state = false

func _ready() -> void:
	reset_values()
