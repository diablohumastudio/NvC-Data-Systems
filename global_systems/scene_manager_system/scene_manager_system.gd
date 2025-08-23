extends Node

func change_scene(scene: PackedScene, arguments: Dictionary = {}) -> void:
	var current_scene: Node = get_tree().current_scene
	print(current_scene)
	var new_scene: Node = scene.instantiate()
	
	for key in arguments:
		if key in new_scene:
			new_scene[key] = arguments[key]
	if new_scene.has_method("_sms_initialize"): new_scene._sms_initialize()
	
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene
	current_scene.queue_free()
