class_name AllyLevelSelector extends Control

signal selected_level_changed(level: AllyLevelData)
const _ALLY_LVL_BTN_BUTTON_GROUP_UID : String = "uid://ktw76hems2h8"
var ally_lvl_btns_group : ButtonGroup = load(_ALLY_LVL_BTN_BUTTON_GROUP_UID)
var selected_lvl_btn : AllyLvlBtn
var buyed_levels: Array[AllyLevelData]

func _ready() -> void:
	ally_lvl_btns_group.pressed.connect(_on_ally_lvl_btn_pressed)
	upload_buyed_levels()

func upload_buyed_levels():
	for ally_lvl_btn: AllyLvlBtn in ally_lvl_btns_group.get_buttons():
		if ally_lvl_btn.ally_level.get_saved_ud_ally_level().buyed:
			buyed_levels.append(ally_lvl_btn.ally_level)

func append_new_level_in_buyed_levels(ally_level : AllyLevelData) -> void:
	buyed_levels.append(ally_level)

func _on_ally_lvl_btn_pressed(ally_level_btn:AllyLvlBtn) -> void:
	_set_labels_values(ally_level_btn.ally_level)
	selected_level_changed.emit(ally_level_btn.ally_level)

func _set_labels_values(ally_level: AllyLevelData) -> void:
	%LevelName.text = ally_level.id
	%LevelDescription.text = ally_level.id
