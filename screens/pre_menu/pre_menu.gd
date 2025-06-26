extends Control

func _on_button_pressed() -> void:
	SceneManagerSystem.change_scene(load("res://screens/menu/menu.tscn"))
