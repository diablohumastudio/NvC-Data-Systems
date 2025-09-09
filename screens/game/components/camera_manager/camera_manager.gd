class_name CameraManager extends Camera2D

signal enemies_preview_animation_ended

func show_enemies_preview():
	%AnimationPlayer.play("show_enemies_preview")
	await %AnimationPlayer.animation_finished
	enemies_preview_animation_ended.emit()
	GSS.enemies_preview_animation_ended.emit()
