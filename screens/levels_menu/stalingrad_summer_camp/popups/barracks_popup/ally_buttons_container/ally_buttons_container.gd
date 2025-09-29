class_name AllyButtonsContainer extends Control

signal ally_btn_pressed(ally_btn:AllyBtn)

const _ALLY_BTN_SCENE_UID : String = "uid://cj1lvhqy5v3dr"

var selected_ally_btn : AllyBtn

func populate_container(allies:Array[AllyData]) -> void:
	for child in %ButtonsContainer.get_children():
		child.free()

	for ally in allies:
		var new_ally_btn : AllyBtn = load(_ALLY_BTN_SCENE_UID).instantiate()
		new_ally_btn.ally = ally
		%ButtonsContainer.add_child(new_ally_btn)
		new_ally_btn.pressed.connect(_on_ally_btn_pressed.bind(new_ally_btn))
	
	selected_ally_btn = %ButtonsContainer.get_child(0)

func _on_ally_btn_pressed(ally_btn:AllyBtn) -> void:
	selected_ally_btn.button_pressed = false
	ally_btn_pressed.emit(ally_btn)
	selected_ally_btn = ally_btn
