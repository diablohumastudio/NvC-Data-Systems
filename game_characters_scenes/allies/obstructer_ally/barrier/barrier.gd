class_name Barrier extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

@export var initial_hp : float
var hp : float
var dying : bool
var receiving_damage : bool

func _on_test_dying_btn_pressed() -> void:
	_die()

func _on_test_damage_button_pressed() -> void:
	receive_damage(2.0)
	print("hp: ", hp)
	
func _ready() -> void:
	hp = initial_hp
	%AnimationTree.animation_finished.connect(_on_anim_tree_animation_finished)
	
func receive_damage(damage_points:float) -> void:
	if dying:
		return
	if receiving_damage:
		hp -= damage_points
		return
	receiving_damage = true
	hp -= damage_points
	%AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func _check_dying_conditions() -> void:
	if hp <= 0:
		_die()
	
func _update_base_texture() -> void:
	if hp <= initial_hp * 0.25:
		%Base.play("damaged_3")
	elif hp <= initial_hp * 0.5:
		%Base.play("damaged_2")
	elif hp <= initial_hp * 0.75:
		%Base.play("damaged_1")

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	if animation_name == "receive_damage":
		_check_dying_conditions()
		_update_base_texture()
		receiving_damage = false

func _die() -> void:
	dying = true
