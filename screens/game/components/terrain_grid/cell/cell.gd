class_name Cell extends Button

var placed_ally: Ally
const SC_ALLY_CONTAINER_PKSC: PackedScene = preload("uid://bhw8iapb537a1")

var is_on_removing_state: bool = false

func _on_pressed() -> void:
	if is_on_removing_state:
		if get_child_count() > 0:
			get_child(0).queue_free()
			placed_ally = null
	else:
		if get_child_count() == 0:
			_add_ally()
			GSS.ally_to_place = null

func _add_ally():
	if !GSS.ally_to_place: return
	
	placed_ally = GSS.ally_to_place
	GSS._ally_just_placed.emit(placed_ally)
	
	var new_ally_scene_container: ScAllyContainer = SC_ALLY_CONTAINER_PKSC.instantiate()
	new_ally_scene_container.ally = GSS.ally_to_place
	new_ally_scene_container.level = GSS.ally_to_place.base_level
	add_child(new_ally_scene_container)
