extends Node

signal _ally_just_placed(ally)
signal _game_just_won

var canons_alive: int
var enemies_killed: int
var ally_to_place: Ally

func _ready() -> void:
	reset_values()

func reset_values():
	canons_alive = GC.TOTAL_NUMBER_OF_CANONS
	enemies_killed = 0
	ally_to_place = null
