class_name AirfieldTarget extends CharacterBody2D

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _on_test_dying_btn_pressed() -> void:
	_die()

## This function is called from animation: "give_coin"
func _on_give_coin_finished() -> void:
	%GiveCoinTimer.start()
	
func _on_give_coin_timer_timeout() -> void:
	state_machine_playback.travel("give_coin")

## At the end of "death" animation there is a call to method: Node.queue_free()
func _die() -> void:
	state_machine_playback.travel("death")
