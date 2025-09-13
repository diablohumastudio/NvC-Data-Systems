class_name CameraManager extends Camera2D

signal enemies_preview_animation_ended

@export var moving_attached_nodes: Array[Node]
var moving_attached_nodes_parents: Dictionary[Node,Node]
var moving_attached_nodes_indexes: Dictionary[Node, int]

func show_enemies_preview():
	_get_previous_parents_and_indexes_of_attached_nodes()
	_reparent_atteched_nodes_to_camera()
	%AnimationPlayer.play("show_enemies_preview")
	await %AnimationPlayer.animation_finished
	enemies_preview_animation_ended.emit()
	await get_tree().process_frame
	reparent_attached_nodes_to_previous_parents()

func _get_previous_parents_and_indexes_of_attached_nodes():
	for node in moving_attached_nodes:
		moving_attached_nodes_parents[node] = node.get_parent()
		moving_attached_nodes_indexes[node] = node.get_index()

func _reparent_atteched_nodes_to_camera():
	for node in moving_attached_nodes:
		node.reparent(self)

func reparent_attached_nodes_to_previous_parents():
	for node in moving_attached_nodes:
		var old_parent = moving_attached_nodes_parents[node]	
		var old_index = moving_attached_nodes_indexes[node]
		node.reparent(old_parent)
		old_parent.move_child(node, old_index)
		
func show_black_borders():
	await %BlackBordersFilter._show()

func hide_black_borders():
	%BlackBordersFilter._hide()
