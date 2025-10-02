class_name IronChest extends ResourceProviderScene

var give_coin_timer_timeout : bool = false
@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")


func _on_test_dying_btn_pressed() -> void:
	_die()
	
## This function is called from animation: "give_coin"
func _on_give_coin_animation_finished() -> void:
	give_coin_timer_timeout = false
	%GiveCoinTimer.start()
	
func _on_give_coin_timer_timeout() -> void:
	give_coin_timer_timeout = true

## At the end of "death" animation there is a call to method: Node.queue_free()
func _die() -> void:
	state_machine_playback.travel("death")
