class_name BlackBorders extends TextureRect

func _show() -> void:
	visible = true
	var tween : Tween = create_tween()
	await tween.tween_property($".", "modulate", Color(1,1,1,1), 5).finished

func _hide():
	var tween : Tween = create_tween()
	await tween.tween_property($".", "modulate", Color(0,0,0,0), 1).finished
	visible = false
