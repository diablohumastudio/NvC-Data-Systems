class_name BlackBorders extends TextureRect

var visibility : bool = false : set = _set_visibility 

func _set_visibility(new_value: bool) -> void:
	if new_value == true:
		var tween : Tween = create_tween()
		tween.tween_property($".", "modulate", Color(1,1,1,1), 1)
	else:
		self.modulate = Color(0,0,0,0)
