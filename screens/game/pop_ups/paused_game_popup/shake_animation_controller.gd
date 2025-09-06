## Controls shake animation effects for nodes
## Manages shake strength, fade effect and random offset calculations
class_name ShakeAnimationController extends Node

## Node to apply the shake animation to
@export var animate_node: Node
## Maximum random strength of the shake effect
@export var _random_strength: float = 30
## Rate at which the shake effect fades out
@export var _shake_fade_effect: float = 5.0

## Current strength of the shake effect
var _shake_strenght: float = 0.0
## Current position offset from shake
var current_offset : Vector2

## Updates the shake animation each physics frame
## Parameters:
## - delta: Time since last frame
func _physics_process(delta):
	if _shake_strenght > 0.001:
		_shake_strenght = lerpf(_shake_strenght, 0, _shake_fade_effect * delta)
		current_offset = _random_offset()
		animate_node.position = current_offset

## Initiates a shake animation with default strength
func apply_shake():
	_shake_strenght = _random_strength
	
## Generates a random offset vector for the shake effect
## Returns: Random 2D offset based on current shake strength
func _random_offset() -> Vector2:
	return Vector2(randf_range(_shake_strenght, _shake_strenght),randf_range(-_shake_strenght, _shake_strenght))
