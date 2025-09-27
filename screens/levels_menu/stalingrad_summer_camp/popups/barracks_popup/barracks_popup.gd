class_name BarracksPopup extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var allies : Array[AllyData]

func _ready() -> void:
	%AllyButtonsContainer.populate_container(allies)

func show_popup():
	visible = true
	animation_player.play("show_popup")
	
func hide_popup():
	animation_player.play("hide_popup")
	await animation_player.animation_finished
	visible = false
	
