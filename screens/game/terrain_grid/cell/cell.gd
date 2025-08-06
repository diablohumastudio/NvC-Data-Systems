class_name Cell extends Button

signal ally_placed(ally)

var ally: Ally 
const SC_ALLY_CONTAINER_PKSC: PackedScene = preload("uid://bhw8iapb537a1")

var is_on_removing_state: bool = false

func _on_pressed() -> void:
	if is_on_removing_state:
		if get_child_count() > 0:
			get_child(0).queue_free()
	else:
		if get_child_count() == 0:
			_add_ally()
			ally_placed.emit(ally)

func _add_ally():
	if !ally: return
	var new_ally_scene_container: ScAllyContainer = SC_ALLY_CONTAINER_PKSC.instantiate()
	new_ally_scene_container.ally = ally
	new_ally_scene_container.level = ally.base_level
	add_child(new_ally_scene_container)
