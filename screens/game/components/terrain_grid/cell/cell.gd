class_name Cell extends Button

const SC_ALLY_CONTAINER_PKSC: PackedScene = preload("uid://bhw8iapb537a1")

func _on_pressed() -> void:
	_validate_children()
	print( !GSS.removing_ally_state , !is_ocupied() , GSS.ally_to_place)
	if !GSS.removing_ally_state and !is_ocupied() and GSS.ally_to_place:
		_add_ally()
		GSS._ally_just_placed.emit(GSS.ally_to_place)
		GSS.ally_to_place = null

func is_ocupied() -> bool:
	return !get_child_count() == 0

func _validate_children():
	if get_child_count() > 1:
		push_error("Cell MUST NOT have more than one children")
	elif get_child_count() == 1 and !get_child(0) is ScAllyContainer:
			push_error("Cell MUST NOT contain children of diferent class than ScALlyContainer")

func _add_ally():
	var new_ally_scene_container: ScAllyContainer = SC_ALLY_CONTAINER_PKSC.instantiate()
	new_ally_scene_container.ally = GSS.ally_to_place
	new_ally_scene_container.level = GSS.ally_to_place.base_level
	add_child(new_ally_scene_container)
