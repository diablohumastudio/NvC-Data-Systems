class_name Barrier extends CharacterBody2D

var dying : bool = false

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	dying = true

func _self_erase() -> void:
	queue_free()
