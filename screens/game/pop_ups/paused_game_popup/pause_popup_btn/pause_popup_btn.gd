class_name PausePopupBtn extends TextureButton

func _on_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	%ResumePlayer.play("continue_pressed")
