class_name TerrainGridCell extends Cell

const SC_ALLY_CONTAINER_PATH: PackedScene = preload("uid://b1xs0qcyd7lb4")

func _ready() -> void:
	if !Engine.is_editor_hint(): self_modulate = Color.TRANSPARENT

func _on_pressed() -> void:
	_validate_children()
	if !GSS.removing_ally_state and !is_ocupied() and GSS.ally_to_place:
		_add_ally()
		GSS.ally_just_placed.emit(GSS.ally_to_place)
		GSS.ally_to_place = null

func _validate_children():
	if get_child_count() > 1:
		push_error("Cell MUST NOT have more than one children")
	elif get_child_count() == 1 and !get_child(0) is AllySceneContainer:
			push_error("Cell MUST NOT contain children of diferent class than AllySceneContainer")

func _add_ally():
	var new_ally_scene_container: AllySceneContainer = SC_ALLY_CONTAINER_PATH.instantiate()
	new_ally_scene_container.ally = GSS.ally_to_place
	add_child(new_ally_scene_container)
