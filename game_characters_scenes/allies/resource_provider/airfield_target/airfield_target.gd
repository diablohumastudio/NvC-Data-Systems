class_name AirfieldTarget extends CharacterBody2D

## This character has method calls in these animations of AnimationPlayer: "give_coin" (_on_give_coin_finished) and "death" (Node.queue_free())

var giving_coin : bool = false

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _ready() -> void:
	%GiveCoinTimer.timeout.connect(_on_give_coin_timer_timeout)

func _on_give_coin_timer_timeout() -> void:
	giving_coin = true

func _on_give_coin_finished() -> void:
	giving_coin = false
	%GiveCoinTimer.start()

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_dying_btn_pressed() -> void:
	_die()
