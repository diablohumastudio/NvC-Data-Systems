class_name Landmine extends CharacterBody2D

var activated : bool = false
@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/playback")

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
	%ShortOpponentArea.body_entered.connect(_on_short_opponent_area_body_entered)
	%ActivationTimer.timeout.connect(_on_activation_timer_timeout)

func _on_activation_timer_timeout() -> void:
	activated = true
	%BaseTexture.play("activated")

func _on_short_opponent_area_body_entered(_body:Node2D) -> void:
	if activated:
		state_machine_playback.travel("exploding")
	else:
		state_machine_playback.travel("death")

func _self_erase() -> void:
	queue_free()
