class_name GameCharacter extends CharacterBody2D

enum DAMAGE_TYPES {LONG_NORMAL, LONG_FREEZING, SHORT_NORMAL, SHORT_EXPLOSION}

var column: int
var row: int
var is_dying: bool = false

@export var hp : float # Initial HP
var current_hp : float

func _ready() -> void:
	current_hp = hp

func receive_damage(damage_points:float, damage_type:GameCharacter.DAMAGE_TYPES) -> void:
	pass

func check_dying_conditions() -> void:
	pass

func die() -> void:
	pass
