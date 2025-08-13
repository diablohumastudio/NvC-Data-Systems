class_name InnerNodeWithReady extends Control

func _init() -> void:
	print("init inner")

func _ready():
	print("ready inner")

func _enter_tree() -> void:
	print("enter tree inner")
