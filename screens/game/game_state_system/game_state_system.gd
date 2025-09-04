extends Node

@warning_ignore("unused_signal")
signal ally_just_placed(ally: AllyData)
@warning_ignore("unused_signal")
signal game_just_won
signal animation_trigered(animation_type: ANIMATION_TYPES)
signal balance_changed(balance: int)
signal _removing_ally_state_changed(state: bool)
signal star_countdown_finished

enum ANIMATION_TYPES {
	INITIAL_STATE,
	FIRST_WAVE_STARTED,
	LAST_WAVE_STARTED,
	OTHER_ACTION_ACTIVATED,
	COUNTER_REACH_FIVE
}

var level: LevelData
var canons_alive: int
var enemies_killed: int
var ally_to_place: AllyData
var removing_ally_state: bool: set = _set_removing_ally_state
var balance: int : set = _set_balance

func _set_balance(new_value):
	balance = new_value
	balance_changed.emit(balance)

func _set_removing_ally_state(new_value):
		removing_ally_state = new_value
		_removing_ally_state_changed.emit(removing_ally_state)

func _ready() -> void:
	animation_trigered.connect(_on_animation_trigered)
	reset_values()

func _on_animation_trigered(animation_type: ANIMATION_TYPES):
	get_tree().call_group("animatable_elements", "play_animation", animation_type)
	print("anim trig", animation_type)

func reset_values():
	canons_alive = GC.TOTAL_NUMBER_OF_CANONS
	enemies_killed = 0
	ally_to_place = null
	removing_ally_state = false
	
func add_value_to_balance(value_to_add:int):
	balance += value_to_add

func substract_value_from_balance(value_to_substract:int):
	balance -= value_to_substract
