class_name SovietShield extends CharacterBody2D

@export var initial_hp : float
var hp : float

func _ready() -> void:
	hp = initial_hp
	%AnimationPlayer.animation_finished.connect(_on_animation_player_animation_finished)
	%AnimationPlayer.play("spawn")

func receive_damage(damage_points:float) -> void:
	hp -= damage_points
	_update_state_texture()
	%AnimationPlayer.play("receive_damage")

func _update_state_texture() -> void:
	if hp <= initial_hp * 0.25:
		%ShieldState.play("no_slabs")
	elif hp <= initial_hp * 0.5:
		%ShieldState.play("one_slab")
	elif hp <= initial_hp * 0.75:
		%ShieldState.play("two_slabs")

func _check_dying_conditions() -> void:
	if hp <= 0:
		_die()
	
func _on_animation_player_animation_finished(animation_name:String) -> void:
	if animation_name == "receive_damage":
		_check_dying_conditions()

func _die() -> void:
	queue_free()
