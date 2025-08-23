class_name GoToSettingsMenuButton extends TextureButton

func _on_pressed() -> void:
	#AudioSystem.post_event(AK.EVENTS.PLAY_SETTINGS_SELECTED)
	%SettingsPlayer.play("settings_pressed")
