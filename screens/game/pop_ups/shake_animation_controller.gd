class_name ShakeAnimationController extends Node

@export var animate_node: Node
@export var _initial_strength: float = 30
@export var _shake_fade_effect: float = 5.0

var _shake_strenght: float = _initial_strength
var current_offset : Vector2

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta):
	_shake_strenght = lerpf(_shake_strenght, 0, _shake_fade_effect * delta)
	current_offset = _get_random_offset()
	animate_node.position = current_offset
	if _shake_strenght < 0.001: 
		_shake_strenght = _initial_strength
		set_physics_process(false)

func apply_shake():
	set_physics_process(true)

func _get_random_offset() -> Vector2:
	return Vector2(randf_range(-_shake_strenght, _shake_strenght),randf_range(-_shake_strenght, _shake_strenght))
