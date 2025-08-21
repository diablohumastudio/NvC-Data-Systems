class_name ScAlly extends CharacterBody2D

signal pressed

func _ready() -> void:
	%SelectAllyBtn.pressed.connect(_on_select_btn_pressed)

func _on_select_btn_pressed():
	pressed.emit()
