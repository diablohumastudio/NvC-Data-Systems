@tool
class_name PopupPresenter extends SceneContainer

func display_popup_scene(_selected_popup_scene: PackedScene) -> void:
	var selected_popup_scene : Node = _selected_popup_scene.instantiate() 
	SMS.get_container("PopupPresenter").goto_scene(selected_popup_scene)

func display_exit_popup_animation() -> void:
	var popup_scene : Control = get_child(0)
	await popup_scene.display_exit_animation()
