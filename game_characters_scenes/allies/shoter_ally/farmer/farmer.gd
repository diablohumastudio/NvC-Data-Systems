class_name Farmer extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_IDLE_CYCLES : int = 2

var idle_cycles_counter : int = 0
var transition_to_stab : bool = false
var transition_to_shoot : bool = false

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

## This function is called from animation: "check_transitions"
func _check_transitions() -> void:
	var short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	var long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()
	var is_idle_cycle_finished : bool = idle_cycles_counter == MAX_IDLE_CYCLES
	transition_to_stab = short_opponent_detected and is_idle_cycle_finished
	transition_to_shoot = long_opponent_detected and !short_opponent_detected and is_idle_cycle_finished
	
	if !(short_opponent_detected or long_opponent_detected):
		return # No enemies detected so no need to use idle_cycle_counter
	_update_idle_cycle_counter()

func _update_idle_cycle_counter() -> void:
	if idle_cycles_counter == MAX_IDLE_CYCLES:
		idle_cycles_counter = 0 # If idle cycles finished, reset idle_cycles_counter and return
		return
		
	if idle_cycles_counter < MAX_IDLE_CYCLES:
		idle_cycles_counter += 1

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")
