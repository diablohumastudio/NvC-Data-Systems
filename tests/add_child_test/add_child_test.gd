extends Node2D

#func _ready() -> void:
	#print("-----before load")
	#var new_inner_pksc: PackedScene = load("res://tests/add_child_test/inner_node_with_ready.tscn")
	#print("-----after load before instantiate")
	#var new_inner: InnerNodeWithReady = new_inner_pksc.instantiate()
	#print("-----after intantiate before addchild")
	#add_child(new_inner)
	#print("-----after add_child")

#func _ready() -> void:
	#print("-----before new()")
	#var new_inner: InnerNodeWithReady = InnerNodeWithReady.new()
	#print("-----after new() before add_child")
	#add_child(new_inner)
	#print("-----after add_child")

#func _ready() -> void:
	#print("-----before load node script")
	#var new_inner_node_script: Resource = load("res://tests/add_child_test/inner_node_with_ready.gd")
	#print("-----after load before script.new()")
	#var new_inner_node = new_inner_node_script.new()
	#print("-----after load before add_child")
	#add_child(new_inner_node)
	#print("-----after add_child")

#func _ready() -> void:
	#print("-----before load")
	#var new_inner_res_script: Resource = load("res://tests/add_child_test/inner_res_with_init.gd")
	#new_inner_res_script.new()
	#print("-----after load ")

#func _ready() -> void:
	#print("-----before load")
	#var new_inner_res_script: InnerResWithInit = load("res://tests/add_child_test/new_inner_res_with_init.tres")
	#print("-----after load ")

#func _ready() -> void:
	#print("-----before new()")
	#var new_inner: InnerResWithInit = InnerResWithInit.new()
	#print("-----after new() ")

# CONCLUCION EL INIT SE CORRE CUANDO SE HACE NODE.INSTANTIATE()
# o INIT CORRE CUANDO SE HACE NODE.NEW()
# o RESOURSE.NEW()
# o LOADED_SCRIPT.NEW()
# o LOAD(MY_RESOURSE.TRES)
# EL ENTER_TREE Y EL READY CORREN CUANDO SE HACE NODE.ADDCHILD
