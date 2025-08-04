class_name Cell extends Button

var ally: Ally 
const SC_ALLY_CONTAINER_PKSC: PackedScene = preload("uid://bhw8iapb537a1")

func _on_pressed() -> void:
	if !ally: return
	var new_ally_scene_container: ScAllyContainer = SC_ALLY_CONTAINER_PKSC.instantiate()
	new_ally_scene_container.ally = ally
	new_ally_scene_container.level = ally.base_level
	add_child(new_ally_scene_container)
