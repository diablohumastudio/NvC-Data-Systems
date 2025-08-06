class_name GameStateInitializer extends Node

func _ready() -> void:
	GSS.initialize()

func _exit_tree() -> void:
	GSS.reset()
