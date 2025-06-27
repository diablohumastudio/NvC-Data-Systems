extends Node

func change_scene(scene_path: String, arguments: Dictionary = {}) -> void:
	get_tree().change_scene_to_file(scene_path)
	await get_tree().tree_changed
	
	var new_scene: Node = get_tree().current_scene
	
	for key in arguments:
		new_scene[key] = arguments[key]
