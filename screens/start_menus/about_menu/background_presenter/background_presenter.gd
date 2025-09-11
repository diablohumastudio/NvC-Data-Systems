@tool
class_name BackgroundPresenter extends Node2D

func display_background_scene(_selected_background_scene: PackedScene):
	var selected_background_scene : PackedScene = _selected_background_scene
	SMS.change_scene(selected_background_scene, {}, $BackgroundScene, true)
