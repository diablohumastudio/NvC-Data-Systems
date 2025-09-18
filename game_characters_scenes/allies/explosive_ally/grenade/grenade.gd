class_name Grenade extends CharacterBody2D

var exploding : bool = false
var _landing_position : Vector2

func _ready() -> void:
	_landing_position = position
	%ExplosionBlastArea.body_entered.connect(_on_explosion_blast_area_body_entered)
	position.y = - (%GrenadeTexture.get_texture().get_size().y / 2)
	_fall_to_landing_position()

func _fall_to_landing_position() -> void:
	var tween : Tween = create_tween()
	tween.finished.connect(_on_tween_finished)
	
	tween.tween_property(self, "position", _landing_position, 2)

func _on_tween_finished() -> void:
	exploding = true
	%BlastCollShape.shape.size = Vector2(400, 400)

func _on_explosion_blast_area_body_entered(body:Node2D) -> void:
	printt("body entered:",body)
