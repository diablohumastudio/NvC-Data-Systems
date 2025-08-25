extends Node

func change_scene(scene: PackedScene, arguments: Dictionary = {}, current_scene: Node = get_tree().current_scene) -> void:
	var new_scene: Node 
	
	assert(scene.can_instantiate())
	new_scene = scene.instantiate()
	
	for key in arguments:
		if key in new_scene:
			new_scene[key] = arguments[key]
	if new_scene.has_method("_sms_initialize"): new_scene._sms_initialize()
	
	var current_scene_name: String = current_scene.name
	current_scene.name = "OldScene"
	new_scene.name = current_scene_name
	current_scene.get_parent().add_child(new_scene)
	if current_scene == get_tree().current_scene: get_tree().current_scene = new_scene
	current_scene.queue_free()
