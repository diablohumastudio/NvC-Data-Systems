class_name NodeShaker extends Node

@export var animate_node: Node
@export var initial_strength: float = 30
@export var shake_fade_effect: float = 5.0

var _shake_strenght: float = initial_strength
var _node_initial_position

func _ready() -> void:
	_reset()

func _reset():
	_node_initial_position = animate_node.position
	_shake_strenght = initial_strength
	set_physics_process(false)

func _physics_process(delta):
	_shake_strenght = lerpf(_shake_strenght, 0, shake_fade_effect * delta)
	animate_node.position = _node_initial_position + _get_random_offset()
	if _shake_strenght < 0.001: 
		_reset()

func apply_shake():
	set_physics_process(true)

func _get_random_offset() -> Vector2:
	return Vector2(randf_range(-_shake_strenght, _shake_strenght),randf_range(-_shake_strenght, _shake_strenght))
