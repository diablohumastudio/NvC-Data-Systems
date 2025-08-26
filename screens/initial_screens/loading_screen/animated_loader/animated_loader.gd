class_name AnimatedLoader extends Node2D
## Class that plays a ping-pong loading animation while the setted resource loads
## asyncronously. When complete loading process plays the finished animation.

## It set the path of the scene you want to load.
@export var scene_to_load_path:String

## Plays the loading loop, ask for asyncrhonous loader to load the scene found in the path 
## set in editor, and keep playing loading loop until it gets the scene. Then it plays the 
## animation without loop (finish animation), and return the scene.
func load() -> void:
	%AnimationPlayer.play("_loading")

	await SLS.add_scene(scene_to_load_path)

	var loading_animation:Animation = %AnimationPlayer.get_animation(%AnimationPlayer.current_animation)
	loading_animation.loop_mode = Animation.LOOP_NONE

	await %AnimationPlayer.animation_finished

	%AnimationPlayer.queue("_finished_loading")
	
	return
