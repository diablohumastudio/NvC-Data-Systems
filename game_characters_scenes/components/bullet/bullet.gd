class_name Bullet extends CharacterBody2D

var bullet_sender : GameCharacter 
var _inflicted_damage_points : int
var _is_moving_right : bool = true

func _ready() -> void:
	_move()

func _move():
	var tween: Tween = get_tree().create_tween()
	if _is_moving_right:
		tween.tween_property(self,"position", Vector2(self.position.x + 1920, self.position.y), 10)
