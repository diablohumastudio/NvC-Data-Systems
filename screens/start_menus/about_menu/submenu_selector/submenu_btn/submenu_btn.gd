class_name SubmenuBtn extends TextureButton

@export var background_scene: PackedScene
@export var popup_scene: PackedScene

func _on_toggled(toggled_on:bool):
	AudioSystem.post_event(AK.EVENTS.PLAY_WORLD_SELECTED)
	if toggled_on:
		%AnimationPlayer.play("_bw_to_color")
	else:
		%AnimationPlayer.play("_color_to_bw")
