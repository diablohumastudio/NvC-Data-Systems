class_name AllySelector extends Control

signal ally_btn_pressed(ally_btn:AllyBtn)

const _ALLY_BTN_SCENE_UID : String = "uid://cj1lvhqy5v3dr"
const ally_btn_pksc: PackedScene = preload(_ALLY_BTN_SCENE_UID)

var selected_ally_btn : AllyBtn

func populate_container(allies:Array[AllyData]) -> void:
	for child in %ButtonsContainer.get_children():
		child.free()

	for ally in allies:
		print("populating container", ally.base_level.buyed_by_default, ally.base_level.get_saved_ud_ally_level().buyed)
		#if ally.base_level.buyed_by_default and !ally.base_level.get_saved_ud_ally_level().buyed:
			#ACS.set_action(Action.new(Action.TYPES.BUYED_ALLY_LEVEL, PayBuyedAllyLevel.new(ally.base_level.id, ally.base_level.ally_id)))
	
		var new_ally_btn : AllyBtn = ally_btn_pksc.instantiate()
		new_ally_btn.ally = ally
		%ButtonsContainer.add_child(new_ally_btn)
		new_ally_btn.pressed.connect(_on_ally_btn_pressed.bind(ally))
		
	
	%ButtonsContainer.get_child(0).button_pressed = true

func _on_ally_btn_pressed(ally_btn:AllyBtn) -> void:
	ally_btn_pressed.emit(ally_btn)
	selected_ally_btn = ally_btn
