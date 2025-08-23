@tool
class_name BackgroundPresenter extends SceneContainer

func display_background_scene(_selected_background_scene: PackedScene):
	var selected_background_scene : Node = _selected_background_scene.instantiate() 
	SMS.get_container("BackgroundPresenter").goto_scene(selected_background_scene)
