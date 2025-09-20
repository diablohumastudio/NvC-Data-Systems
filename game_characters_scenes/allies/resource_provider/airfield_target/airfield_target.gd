class_name AirfieldTarget extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _on_give_coin_timer_timeout() -> void:
	state_machine_playback.travel("give_coin")

## This function is called from animation: "give_coin"
func _on_give_coin_finished() -> void:
	%GiveCoinTimer.start()

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_dying_btn_pressed() -> void:
	_die()
