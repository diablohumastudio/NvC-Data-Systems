class_name DbugTriggerAnimationBtn extends Button

func _on_pressed() -> void:
	var anim_type: GSS.ANIMATION_TYPES = GSS.ANIMATION_TYPES[%TextEdit.text]
	GSS.animation_trigered.emit(anim_type)
