class_name GoToGamesMenuButton extends TextureButton

func _on_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_START_SELECTED)
	%StartPlayer.play("start_pressed")
