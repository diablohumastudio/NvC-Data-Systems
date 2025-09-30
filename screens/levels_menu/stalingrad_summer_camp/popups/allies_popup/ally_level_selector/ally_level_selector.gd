class_name AllyLevelSelector extends Control

signal level_btn_pressed(level_btn:AllyLvlBtn)
const _ALLY_LVL_BTN_BUTTON_GROUP_UID : String = "uid://ktw76hems2h8"

func _ready() -> void:
	_connect_ally_lvl_btns_signals()

func _connect_ally_lvl_btns_signals():
	var ally_lvl_btns_group : ButtonGroup = load(_ALLY_LVL_BTN_BUTTON_GROUP_UID)
	#print(ally_lvl_btns_group)
	for ally_lvl_btn in ally_lvl_btns_group.get_buttons():
		ally_lvl_btn.pressed.connect(_on_ally_lvl_btn_pressed.bind(ally_lvl_btn))

func _on_ally_lvl_btn_pressed(btn:AllyLvlBtn) -> void:
	level_btn_pressed.emit(btn)
