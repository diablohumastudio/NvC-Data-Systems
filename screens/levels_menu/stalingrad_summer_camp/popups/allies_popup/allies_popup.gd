class_name AlliesPopup extends Control

@export var allies : Array[AllyData]
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var current_ally : AllyData : set = set_current_ally
var applied_levels: Array[AllyLevelData] # Is the array of levels that are going to change the scene in AllyPreview

func _ready() -> void:
	var ally_btn_button_group: ButtonGroup = load("uid://cqt0vw3k8fvay")
	ally_btn_button_group.pressed.connect(_on_ally_btn_button_group_pressed)

	%AllyButtonsContainer.populate_container(allies)

	current_ally = ally_btn_button_group.get_pressed_button().ally

	%AllyLevelSelector.selected_level_changed.connect(_on_ally_level_selector_selected_level_changed)

func _set_upgrade_button_price_label(ally_level : AllyLevelData) -> void:
	%AllyPreview.set_upgrade_price_label(ally_level.market_price)

func set_current_ally(new_value:AllyData) -> void:
	current_ally = new_value
	%AllyPreview.display_ally_scene(load(current_ally.base_level.scene_path)) # TODO: change scene when level is changed

func show_popup():
	visible = true
	animation_player.play("show_popup")
	
func hide_popup():
	animation_player.play("hide_popup")
	await animation_player.animation_finished
	visible = false

func _on_ally_level_selector_selected_level_changed(ally_level : AllyLevelData) -> void:
	applied_levels = %AllyLevelSelector.buyed_levels.duplicate()
	applied_levels.append(ally_level)
	_set_upgrade_button_price_label(ally_level)

func _on_ally_btn_button_group_pressed(ally_btn:AllyBtn):
	current_ally = ally_btn.ally
