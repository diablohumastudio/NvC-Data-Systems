class_name Disclaimer extends Control


func _ready() -> void:
	_display_intro_animation()

func _display_intro_animation() -> void:
	var tween = get_tree().create_tween()
	%Sign.position = Vector2(%Sign.position.x, -2000)
	tween.tween_property(%Sign, "position", Vector2(%Sign.position.x, 0), .7)

func display_exit_animation() -> void:
	var tween = get_tree().create_tween()
	await tween.tween_property(%Sign, "position", Vector2(%Sign.position.x, -2000), .7).finished
