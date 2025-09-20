class_name IronChest extends CharacterBody2D

var give_coin_timer_timeout : bool = false
@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _on_give_coin_animation_finished() -> void:
	give_coin_timer_timeout = false
	%GiveCoinTimer.start()

func _on_give_coin_timer_timeout() -> void:
	give_coin_timer_timeout = true

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_dying_btn_pressed() -> void:
	_die()
