class_name CollaboratorPresentersContainer extends GridContainer

const _COLLABORATOR_PRESENTER_PATH : String = "uid://bsqnw2ullfe4c"
 
var _collaborators: Array[Collaborator]

func _ready() -> void:
	_clear_grid_children()
	_collaborators = _get_collaborators()
	_display_collaborator_presenters()
	

func _display_collaborator_presenters():
	for ii in _collaborators.size():
		var collaborator : Collaborator = _collaborators[ii]
		var collaborator_presenter : CollaboratorPresenter =  load(_COLLABORATOR_PRESENTER_PATH).instantiate()
		add_child(collaborator_presenter)
		collaborator_presenter.collaborator = collaborator

func _get_collaborators() -> Array[Collaborator]:
	var _saved_collaborators: Array[Collaborator]
	var dir := DirAccess.open("res://screens/start_menus/about_menu/submenus/credits/popup/collaborator_presenter/collaborator/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var collaborator: Collaborator = load(dir.get_current_dir() + "/" + file)
		_saved_collaborators.append(collaborator)
	return _saved_collaborators


func _clear_grid_children():
	for child in get_children():
		child.queue_free()
