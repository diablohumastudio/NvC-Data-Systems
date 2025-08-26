class_name SubmenuSelector extends Control

signal submenu_selected(submenu_background:PackedScene, submenu_popup_scene:PackedScene)

func _ready():
	var submenu_buttons = %SubmenuButtons.get_children()
	var initial_submenu_btn:SubmenuBtn = submenu_buttons[0]
	
	for submenu_button in submenu_buttons as Array[SubmenuBtn]:
		submenu_button.pressed.connect(_on_submenu_button_pressed.bind(submenu_button.background_scene, submenu_button.popup_scene))
	initial_submenu_btn.set_pressed(true)

func _on_submenu_button_pressed(background_scene: PackedScene, popup_scene: PackedScene):
	submenu_selected.emit(background_scene, popup_scene)
