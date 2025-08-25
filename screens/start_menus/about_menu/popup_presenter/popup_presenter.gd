@tool
class_name PopupPresenter extends Node2D

func display_popup_scene(_selected_popup_scene: PackedScene) -> void:
	var selected_popup_scene : PackedScene = _selected_popup_scene
	SMS.change_scene(selected_popup_scene, {}, $PopupScene1)

func display_exit_popup_animation() -> void:
	var popup_scene : Control = get_child(0)
	await popup_scene.display_exit_animation()
