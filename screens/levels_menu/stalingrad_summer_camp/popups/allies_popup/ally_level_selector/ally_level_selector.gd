class_name AllyLevelSelector extends Control

signal level_btn_pressed(level_btn:AllyLvlBtn)
const _ALLY_LVL_BTN_BUTTON_GROUP_UID : String = "uid://ktw76hems2h8"
var selected_lvl_btn : AllyLvlBtn : set = _set_selected_lvl_btn
var applied_levels : Array[AllyLevelData]

func _ready() -> void:
	_connect_ally_lvl_btns_signals()

func _connect_ally_lvl_btns_signals():
	var ally_lvl_btns_group : ButtonGroup = load(_ALLY_LVL_BTN_BUTTON_GROUP_UID)
	for ally_lvl_btn in ally_lvl_btns_group.get_buttons():
		ally_lvl_btn.pressed.connect(_on_ally_lvl_btn_pressed.bind(ally_lvl_btn))

func _set_selected_lvl_btn(new_value:AllyLvlBtn) -> void:
	selected_lvl_btn = new_value
	_set_labels_values()

func _set_labels_values() -> void:
	%LevelName.text = selected_lvl_btn.ally_level.id
	%LevelDescription.text = selected_lvl_btn.ally_level.id

func _on_ally_lvl_btn_pressed(btn:AllyLvlBtn) -> void:
	if btn:
		selected_lvl_btn = btn
		level_btn_pressed.emit(selected_lvl_btn)
