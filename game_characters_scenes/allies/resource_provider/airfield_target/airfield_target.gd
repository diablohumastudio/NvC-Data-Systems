class_name AirfieldTarget extends CharacterBody2D

var giving_coin : bool = false

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _ready() -> void:
	%GiveCoinTimer.timeout.connect(_on_give_coin_timer_timeout)
	%AnimationTree.animation_finished.connect(_on_anim_tree_animation_finished)

func _on_give_coin_timer_timeout() -> void:
	giving_coin = true

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	if animation_name == "give_coin":
		giving_coin = false
		%GiveCoinTimer.start()
	elif animation_name == "death":
		queue_free()

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_dying_btn_pressed() -> void:
	_die()
