class_name WoodenBarrier extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

@export var initial_hp : float
var hp : float

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

func _on_test_dying_btn_pressed() -> void:
	_die()

func _ready() -> void:
	hp = initial_hp
	
func receive_damage(damage_points:float) -> void:
	hp -= damage_points
	
	_check_dying_conditions()
	_update_base_texture()
	
func _check_dying_conditions() -> void:
	if hp <= 0:
		_die()
	
func _update_base_texture() -> void:
	if hp <= initial_hp * 0.25:
		%BarrierTexture.play("damaged_3")
	elif hp <= initial_hp * 0.5:
		%BarrierTexture.play("damaged_2")
	elif hp <= initial_hp * 0.75:
		%BarrierTexture.play("damaged_1")

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	if animation_name == "receive_damage":
		print("receive_damage animation finished")

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_damage_button_pressed() -> void:
	receive_damage(2.0)
	%AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	print("hp: ", hp)
