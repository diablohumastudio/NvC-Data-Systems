class_name BayonetSoldier extends CharacterBody2D

var cooldown_idle_cycle_complete : bool = false
var short_opponent_detected : bool
var long_opponent_detected : bool

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")
@onready var idle_animation : Animation = %AnimationPlayer.get_animation("idle")

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

func _ready() -> void:
	%AnimationTree.animation_finished.connect(_on_anim_tree_animation_finished)

func _check_for_opponents() -> void:
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()
	
	if short_opponent_detected or long_opponent_detected:
		idle_animation.loop_mode = Animation.LOOP_NONE

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	print("animation finished: ", animation_name)
	if animation_name == "idle":
		if !cooldown_idle_cycle_complete:
			state_machine_playback.start("idle")
			cooldown_idle_cycle_complete = true
		else:
			cooldown_idle_cycle_complete = false
			if short_opponent_detected:
				state_machine_playback.travel("stab")
			elif long_opponent_detected and !short_opponent_detected:
				state_machine_playback.travel("shoot")
			elif !short_opponent_detected and !long_opponent_detected:
				idle_animation.loop_mode = Animation.LOOP_LINEAR
				state_machine_playback.start("idle")

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")

func _self_erase() -> void:
	queue_free()
