class_name NodesInArratyTest extends Control

const inner_node_uid: String = "uid://c5rfnytfd8iwv"
var inner_node_pksc: PackedScene = load(inner_node_uid)
var inner_nodes: Array[InnerNode] = []

func _on_add_inner_node_btn_pressed() -> void:
	var new_inner_node: InnerNode = inner_node_pksc.instantiate()
	new_inner_node.removed.connect(on_inner_node_removed)
	inner_nodes.append(new_inner_node)
	%InnerNodeContainer.add_child(new_inner_node)

func on_inner_node_removed(node: InnerNode):
	inner_nodes.remove_at(inner_nodes.find(node))

func _on_print_inner_nodes_pressed() -> void:
	print(inner_nodes)
