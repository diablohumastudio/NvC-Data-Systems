extends Node

@warning_ignore("unused_signal")
signal ally_just_placed(ally: AllyData)
@warning_ignore("unused_signal")
signal game_just_won
signal triger_animation

signal _removing_ally_state_changed(state: bool)

var level: LevelData
var canons_alive: int
var enemies_killed: int
var ally_to_place: AllyData
var removing_ally_state: bool: set = _set_removing_ally_state

func _set_removing_ally_state(new_value):
		removing_ally_state = new_value
		_removing_ally_state_changed.emit(removing_ally_state)

func _ready() -> void:
	reset_values()

func reset_values():
	canons_alive = GC.TOTAL_NUMBER_OF_CANONS
	enemies_killed = 0
	ally_to_place = null
	removing_ally_state = false
