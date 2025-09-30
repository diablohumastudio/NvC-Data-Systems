class_name AlliesPopup extends Control

@export var allies : Array[AllyData]
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var current_ally : AllyData : set = set_current_ally


func _ready() -> void:
	%AllyButtonsContainer.ally_btn_pressed.connect(_on_ally_buttons_container_ally_btn_pressed)
	%AllyButtonsContainer.populate_container(allies)

	%AllyButtonsContainer.selected_ally_btn.button_pressed = true
	current_ally = %AllyButtonsContainer.selected_ally_btn.ally
	
func set_current_ally(new_value:AllyData) -> void:
	current_ally = new_value
	_display_ally_preview()

func _display_ally_preview() -> void:
	%AllyPreview.display_ally_scene(load(current_ally.base_level.scene_path))

func show_popup():
	visible = true
	animation_player.play("show_popup")
	
func hide_popup():
	animation_player.play("hide_popup")
	await animation_player.animation_finished
	visible = false
	
func _on_ally_buttons_container_ally_btn_pressed(ally_btn:AllyBtn):
	if ally_btn:
		current_ally = ally_btn.ally
