extends Node

func change_scene(scene_path: PackedScene, arguments: Dictionary = {}) -> void:
	get_tree().change_scene_to_packed(scene_path)
	await get_tree().tree_changed
	
	var new_scene: Node = get_tree().current_scene
	
	for key in arguments:
		new_scene[key] = arguments[key]
	
	if new_scene.has_method("_initial_setup"): new_scene._initial_setup()
