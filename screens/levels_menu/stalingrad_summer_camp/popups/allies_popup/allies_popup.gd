class_name AlliesPopup extends Control

const _ALLY_LVL_BTN_BUTTON_GROUP_UID : String = "uid://ktw76hems2h8"
@export var allies : Array[AllyData]
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ally_btn_button_group: ButtonGroup = load("uid://cqt0vw3k8fvay")
@onready var ally_lvl_btns_group : ButtonGroup = load(_ALLY_LVL_BTN_BUTTON_GROUP_UID)
var selected_ally : AllyData : set = set_selected_ally
var applied_levels: Array[AllyLevelData] # Is the array of levels that are going to change the scene in AllyPreview

func _ready() -> void:
	ally_btn_button_group.pressed.connect(_on_ally_btn_button_group_pressed)
	%AllyPreview.upgrade_btn_pressed.connect(_on_ally_preview_upgrade_btn_pressed)
	%AllySelector.populate_container(allies)
	
	selected_ally = ally_btn_button_group.get_pressed_button().ally

	%AllyLevelSelector.selected_level_changed.connect(_on_ally_level_selector_selected_level_changed)

func _set_upgrade_button_price_label(ally_level : AllyLevelData) -> void:
	%AllyPreview.set_upgrade_price_label(ally_level.market_price)

func set_selected_ally(new_value:AllyData) -> void:
	selected_ally = new_value
	%AllyPreview.display_ally_scene(load(selected_ally.base_level.scene_path)) # TODO: change scene when level is changed

func show_popup():
	visible = true
	animation_player.play("show_popup")
	
func hide_popup():
	animation_player.play("hide_popup")
	await animation_player.animation_finished
	visible = false

func _on_ally_preview_upgrade_btn_pressed() -> void:
	var selected_ally_level_btn : AllyLvlBtn = ally_lvl_btns_group.get_pressed_button()
	if !selected_ally_level_btn:
		print("Trying to buy a locked ally level")
		return
	var current_ally_level : AllyLevelData = selected_ally_level_btn.ally_level
	ACS.set_action(Action.new(Action.TYPES.BUYED_ALLY_LEVEL, PayBuyedAllyLevel.new(current_ally_level.id, current_ally_level.ally_id)))
	selected_ally_level_btn.buyed = true
	%AllyLevelSelector.append_new_level_in_buyed_levels(current_ally_level)
	
func _on_ally_level_selector_selected_level_changed(ally_level : AllyLevelData) -> void:
	applied_levels = %AllyLevelSelector.buyed_levels.duplicate()
	applied_levels.append(ally_level)
	_set_upgrade_button_price_label(ally_level)

func _on_ally_btn_button_group_pressed(ally_btn:AllyBtn):
	selected_ally = ally_btn.ally

func _on_exit_button_pressed() -> void:
	hide_popup()
