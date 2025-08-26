class_name SLSBank extends Node

signal scene_loaded(path:String)
signal all_scenes_loaded

@export var scenes_paths: Array[String] = []
@export var auto_loading: bool = true

var are_all_scenes_loaded: bool = false

func _ready() -> void:
	if auto_loading: load_scenes()

func load_scenes():
	SLS.scene_loaded.connect(func(scene_path:String): scene_loaded.emit(scene_path))
	SLS.all_scenes_loaded.connect(func(): 
		all_scenes_loaded.emit()
		are_all_scenes_loaded = true)
	SLS.replace_scenes(scenes_paths)
	
