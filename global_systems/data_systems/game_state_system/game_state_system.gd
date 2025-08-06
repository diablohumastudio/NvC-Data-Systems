extends Node

var game_state: GameState 

func _get(property_name: StringName):
	return game_state.get(property_name)

func _set(property_name: StringName, value: Variant):
	game_state.set(property_name, value)
	return true

func initialize():
	game_state = GameState.new()

func reset():
	property_list_changed
	game_state = null 

class GameState extends Resource:
	var canons_alive: int = GC.TOTAL_NUMBER_OF_CANONS
	var enemies_killed: int = 0
