class_name IronChest extends CharacterBody2D

var giving_coin : bool = false
var dying : bool = false

func _ready() -> void:
	%AnimationTree.animation_finished.connect(_on_anim_tree_animation_finished)
	%GiveCoinTimer.timeout.connect(_on_give_coin_timer_timeout)

func _toggle_idle_loop_mode() -> void:
	var idle_animation : Animation = %AnimationPlayer.get_animation("idle")
	
	if idle_animation.loop_mode == Animation.LOOP_LINEAR:
		idle_animation.loop_mode = Animation.LOOP_NONE
	elif idle_animation.loop_mode == Animation.LOOP_NONE:
		idle_animation.loop_mode = Animation.LOOP_LINEAR

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	if animation_name == "idle":
		giving_coin = true
	elif animation_name == "give_coin":
		_toggle_idle_loop_mode()
		giving_coin = false
		%GiveCoinTimer.start()
	elif animation_name == "death":
		queue_free()

func _on_give_coin_timer_timeout() -> void:
	_toggle_idle_loop_mode()

func _die() -> void:
	dying = true

func _on_test_dying_btn_pressed() -> void:
	_die()
