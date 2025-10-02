class_name EagleGerman extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_WAIT_CYCLES : int = 1
var wait_cycles_counter : int = 0
var are_wait_cycles_completed : bool
var short_opponent_detected : bool 
var long_opponent_detected : bool 
var is_walking : bool = true
var already_attacked : bool
var eagle_already_called : bool

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

func _on_land_on_ground_anim_started() -> void:
	is_walking = true
	
func _on_land_on_ground_anim_finished() -> void:
	eagle_already_called = true
	is_walking = false

func _check_transitions() -> void:
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()

	if is_walking:
		if short_opponent_detected:
			if eagle_already_called:
				are_wait_cycles_completed = true
			else:
				is_walking = false
		elif !short_opponent_detected and long_opponent_detected:
			are_wait_cycles_completed = wait_cycles_counter == MAX_WAIT_CYCLES
			_update_wait_cycles_counter()
	else:
		if short_opponent_detected and eagle_already_called:
			are_wait_cycles_completed = wait_cycles_counter == MAX_WAIT_CYCLES
			_update_wait_cycles_counter()
		elif !short_opponent_detected and long_opponent_detected:
			if already_attacked:
				is_walking = true
			else:
				are_wait_cycles_completed = true

func _on_walking_animation_starting() -> void:
	is_walking = true
	already_attacked = false

func _on_idle_animation_starting() -> void:
	is_walking = false
	already_attacked = false

func _on_offensive_animation_starting() -> void:
	is_walking = false
	are_wait_cycles_completed = false
	already_attacked = true

func _update_wait_cycles_counter() -> void:
	if wait_cycles_counter == MAX_WAIT_CYCLES:
		wait_cycles_counter = 0
		return
	wait_cycles_counter += 1

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")
