class_name HandgunGerman extends EnemyScene

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_IDLE_CYCLES : int = 2
const MAX_WALKING_CYCLES : int = 2

var idle_cycles_counter : int = 0
var walking_cycles_counter : int = 0

var short_opponent_detected : bool = false
var long_opponent_detected : bool = false
var transition_to_stab : bool = false
var transition_to_shoot : bool = false
var transition_to_idle : bool = false
var transition_to_walking : bool = false

var is_walking : bool = true
var already_attacked : bool = false

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

#region For testing Only. Just creates an object where mouse click
const TEST_BODY_PKSC: PackedScene = preload("uid://didykuwbgj0mj")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		event = event as InputEventMouse
		var new_test_body: TestBody = TEST_BODY_PKSC.instantiate()
		new_test_body.set_collision_layer_value(2, true)
		add_child(new_test_body)
		new_test_body.global_position = event.position
#endregion

func _process(_delta: float) -> void:
	if is_walking:
		position.x -= 0.8

func _check_for_opponents() -> void:
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()

func _update_animation_cycles_counter() -> void:
	if is_walking:
		if walking_cycles_counter == MAX_WALKING_CYCLES:
			walking_cycles_counter = 0 # If walking cycles finished, reset walking_cycles_counter and return
			return
			
		if walking_cycles_counter < MAX_WALKING_CYCLES:
			walking_cycles_counter += 1
	else:
		if idle_cycles_counter == MAX_IDLE_CYCLES:
			idle_cycles_counter = 0 # If idle cycles finished, reset idle_cycles_counter and return
			return
			
		if idle_cycles_counter < MAX_IDLE_CYCLES:
			idle_cycles_counter += 1

## This function is called from animation: "check_transitions"
func _check_transitions() -> void:
	transition_to_stab = false
	transition_to_shoot = false
	var is_idle_cycle_finished : bool = idle_cycles_counter == MAX_IDLE_CYCLES
	
	_check_for_opponents()
	
	# Walking and shooting to long range opponent, idle cycles after attack and going back to walking
	if already_attacked and long_opponent_detected and !short_opponent_detected:
		_update_animation_cycles_counter()
		if is_idle_cycle_finished:
			transition_to_idle = false
			transition_to_walking = true
			already_attacked = false
			idle_cycles_counter = 0
		return
	
	#Transitioning to attack states
	transition_to_stab = short_opponent_detected and is_idle_cycle_finished
	transition_to_shoot = long_opponent_detected and !short_opponent_detected and is_idle_cycle_finished
	
	if transition_to_stab or transition_to_shoot:
		already_attacked = true
	else:
		already_attacked = false
	
	# Going back to walking state if no enemies detected after idle cycles complete
	if !(short_opponent_detected or long_opponent_detected):
		if is_idle_cycle_finished:
			transition_to_walking = true
			idle_cycles_counter = 0
		else:
			_update_animation_cycles_counter()
		return 
	
	# Updating idle cycles counter to attack in next cycles
	_update_animation_cycles_counter()

## This function is called from animation: "idle"
func _on_idle_animation_starting() -> void:
	transition_to_idle = false
	is_walking = false

## This function is called from animation: "walking"
func _on_walking_animation_starting() -> void:
	transition_to_walking = false
	is_walking = true

## This function is called from animation: "walking"
func _on_walking_animation_finished() -> void:
	var is_walking_cycle_finished : bool = walking_cycles_counter == MAX_IDLE_CYCLES
	_check_for_opponents()
	
	transition_to_idle = short_opponent_detected or (long_opponent_detected and is_walking_cycle_finished)
	
	if !(short_opponent_detected or long_opponent_detected):
		walking_cycles_counter = 0
		return # No enemies detected so no need to use walking_cycle_counter

	_update_animation_cycles_counter()

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")
