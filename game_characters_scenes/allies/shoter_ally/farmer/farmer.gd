class_name Farmer extends CharacterBody2D

## This character has method calls in these animations of AnimationPlayer: 
## "idle" (_on_idle_animation_finished()) "shoot" and "stab" (_on_offensive_animation_finished()) and "death" (Node.queue_free())

var cooldown_idle_cycles_counter : int = 0
var short_opponent_detected : bool
var long_opponent_detected : bool

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

func _transition_to_offensive_state() -> void:
	if short_opponent_detected:
		state_machine_playback.travel("stab")
	elif long_opponent_detected and !short_opponent_detected:
		state_machine_playback.travel("shoot")

func _on_idle_animation_finished() -> void:
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()
	
	if short_opponent_detected or long_opponent_detected:
		if cooldown_idle_cycles_counter < 2:
			cooldown_idle_cycles_counter += 1
		else: 
			cooldown_idle_cycles_counter = 0
			_transition_to_offensive_state()

func _on_offensive_animation_finished() -> void:
	state_machine_playback.travel("idle")

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")
