class_name AsyncLoader extends Node
## Provides an easy interface 
## to asynchronous load resources. 

## Used internally, emitted from _process() function for knowing when the resourse 
## is ready to get from ResourseLoader
signal _load_status_is_loaded

var _resource_path

func _ready() -> void:
	set_process(false)

## Loads the resourse located in the recieved path. Use native asynchronously loader and check in _process()
## function to emit signal, get the signal y this function and return the resourse. 
func load_resource(resource_path: String) -> Resource:
	_resource_path = resource_path
	if not _is_path_valid(resource_path): return

	ResourceLoader.load_threaded_request(_resource_path)
	set_process(true)
	await _load_status_is_loaded

	var loaded_resource : Resource = ResourceLoader.load_threaded_get(_resource_path)
	return loaded_resource

func _is_path_valid(resource_path: String) -> bool:
	if resource_path == "":
		push_warning("resource_path argument must not be empty")
		return false
	if not ResourceLoader.exists(_resource_path):
		push_warning("There is not file in ", resource_path)
		return false
	return true

func _process(delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(_resource_path) == ResourceLoader.THREAD_LOAD_LOADED:
		_load_status_is_loaded.emit()
		set_process(false)
