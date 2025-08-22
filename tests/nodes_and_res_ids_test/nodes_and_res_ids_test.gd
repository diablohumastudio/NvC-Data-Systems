extends Control

var id
var my_external_res: ResWithId = ResWithId.new()
var my_script_instanced_res: ResWithId = load("res://tests/nodes_and_res_ids_test/res_with_id/res_with_id.gd").new()
var my_loaded_external_res: ResWithId = load("res://tests/nodes_and_res_ids_test/res_with_id/res_with_id_1.tres")
var my_duplicated_loaded_res: ResWithId = load("res://tests/nodes_and_res_ids_test/res_with_id/res_with_id_1.tres").duplicate()
@export var my_exported_external_res_with_id: ResWithId

func _ready() -> void:
	print("test ready my_ext_res  ", my_external_res.resource_path, my_external_res.resource_name)
	print("test ready my__scrp_ins", my_script_instanced_res.resource_path, my_script_instanced_res.resource_name)
	print("test ready my_loaded_re", my_loaded_external_res.resource_path, my_loaded_external_res.resource_name)
	print("test ready my_duplic_re", my_duplicated_loaded_res.resource_path, my_duplicated_loaded_res.resource_name)
	print("test ready my_expor_res", my_exported_external_res_with_id.resource_path, my_exported_external_res_with_id.resource_name)
	my_external_res.print_resourse_path()
	my_script_instanced_res.print_resourse_path()
	my_loaded_external_res.print_resourse_path()
	my_duplicated_loaded_res.print_resourse_path()
	my_exported_external_res_with_id.print_resourse_path()
