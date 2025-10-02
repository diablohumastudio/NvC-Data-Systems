class_name RomanianSoldier extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_IDLE_CYCLES : int = 2
const MAX_WALKING_CYCLES : int = 1
var idle_cycles_counter : int = 0
var walking_cycles_counter : int = 0

var is_going_to_attack : bool = false
var pre_attack_idle_cycle_complete : bool = false
var already_attacked : bool = false
var cool_down_idle_cycle_complete : bool = false
var walking_cycle_complete : bool = false
var short_opponent_detected : bool = false
var long_opponent_detected : bool = false
var is_walking : bool = true

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
	_check_for_opponents()
	pre_attack_idle_cycle_complete = false
	cool_down_idle_cycle_complete = false
	
	if is_walking:
		if short_opponent_detected:
			# Transitioning to idle state
			is_going_to_attack = true
			walking_cycle_complete = true
		elif !short_opponent_detected and long_opponent_detected:
			# Going to walking cycles
			walking_cycle_complete = walking_cycles_counter == MAX_WALKING_CYCLES
			if walking_cycle_complete:
				# Transitioning to idle state
				is_going_to_attack = true
			_update_animation_cycles_counter()
			return
				
		elif !short_opponent_detected and !long_opponent_detected:
			# Remaining in walking state
			is_going_to_attack = false
	else:
		if is_going_to_attack:
			# Going to idle pre attack idle cycles
			pre_attack_idle_cycle_complete = idle_cycles_counter == MAX_IDLE_CYCLES
			if pre_attack_idle_cycle_complete:
				is_going_to_attack = false
			_update_animation_cycles_counter()
			return
		
		if already_attacked:
			# Going to idle cool down cycles
			cool_down_idle_cycle_complete = idle_cycles_counter == MAX_IDLE_CYCLES
			if cool_down_idle_cycle_complete:
				already_attacked = false
			_update_animation_cycles_counter()
			return

## This function is called from animation: "shoot" and "stab"
func _on_offensive_animation_finished() -> void:
	already_attacked = true

## This function is called from animation: "idle"
func _on_idle_animation_starting() -> void:
	is_walking = false

## This function is called from animation: "walking"
func _on_walking_animation_starting() -> void:
	is_walking = true

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")
