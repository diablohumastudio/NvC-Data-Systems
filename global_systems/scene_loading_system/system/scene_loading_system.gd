## SceneLoadingSystem. Singleton that async load _scenes, save them to a Dictionary asociated to their paths
## and expose that Dictionary.
extends Node

signal scene_loaded(path: String)
signal all_scenes_loaded
signal _load_status_is_loaded

var _scenes: Dictionary [String, PackedScene] 

var _current_scene_path: String

func replace_scenes(scene_paths: Array[String]) -> void:
	var new_scenes: Dictionary [String, PackedScene]
	for scene_path in scene_paths:
		var scene_uid: String = str(ResourceLoader.get_resource_uid(scene_path))
		if _scenes.has(scene_uid):
			new_scenes[scene_uid] = _scenes[scene_uid]
	_scenes = new_scenes
	await add_scenes(scene_paths)

func add_scenes(scene_paths: Array[String]) -> void:
	for path in scene_paths:
		if await add_scene(path):
			scene_loaded.emit(path)
	all_scenes_loaded.emit()

func add_scene(scene_path: String) -> PackedScene:
	_current_scene_path = scene_path
	var scene_uid: String = str(ResourceLoader.get_resource_uid(scene_path))
	
	if not _is_path_valid(scene_path): return
	if _scenes.has(scene_uid):
		push_warning("Scene already loaded.")
		return _scenes[scene_uid]

	ResourceLoader.load_threaded_request(scene_path)
	set_process(true)
	await _load_status_is_loaded

	var loaded_packed_scene : PackedScene = ResourceLoader.load_threaded_get(scene_path)
	
	_scenes[scene_uid] = loaded_packed_scene
	return loaded_packed_scene

func _is_path_valid(scene_path: String) -> bool:
	if scene_path == "":
		push_error("resource_path argument must not be empty")
		return false
	if not ResourceLoader.exists(scene_path):
		push_error("There is not file in ", scene_path, " path.")
		return false
	return true

## Returns the requested scene from the _scenes Array. If not previously loaded, throw error and returns null. 
func get_scene(scene_path: String) -> PackedScene:
	print(_scenes)
	var scene_uid = str(ResourceLoader.get_resource_uid(scene_path))
	if _scenes.has(scene_uid):
		return _scenes[scene_uid]
	else: 
		push_error("Trying to get a scene that is not loaded.")
		return null

func has_scene(scene_path: String) -> bool:
	var scene_uid = str(ResourceLoader.get_resource_uid(scene_path))
	return _scenes.has(scene_uid)

func _process(_delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(_current_scene_path) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		_load_status_is_loaded.emit()
