class_name WoodenChest extends CharacterBody2D

## This character has method calls in these animations of AnimationPlayer: 
## "idle" (_on_idle_animation_finished()) "give_coin" (_on_give_coin_finished()) and "death" (Node.queue_free())

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _toggle_idle_loop_mode() -> void:
	var idle_animation : Animation = %AnimationPlayer.get_animation("idle")
	
	if idle_animation.loop_mode == Animation.LOOP_LINEAR:
		idle_animation.loop_mode = Animation.LOOP_NONE
	elif idle_animation.loop_mode == Animation.LOOP_NONE:
		idle_animation.loop_mode = Animation.LOOP_LINEAR

func _on_idle_animation_finished() -> void:
	var idle_animation : Animation = %AnimationPlayer.get_animation("idle")
	
	if idle_animation.loop_mode == Animation.LOOP_NONE:
		state_machine_playback.travel("give_coin")

func _on_give_coin_finished() -> void:
	_toggle_idle_loop_mode()
	state_machine_playback.travel("idle")
	%GiveCoinTimer.start()

func _on_give_coin_timer_timeout() -> void:
	_toggle_idle_loop_mode()

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_dying_btn_pressed() -> void:
	_die()
