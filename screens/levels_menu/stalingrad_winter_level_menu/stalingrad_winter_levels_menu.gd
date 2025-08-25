class_name StalingradWinterLevelsMenu extends Control

func _on_go_back_button_pressed() -> void:
	var worlds_map_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.WORLDS_MAP_MENU)
	worlds_map_menu.entering_from_salingrad_winter_levels_menu = true

	SMS.goto_scene(worlds_map_menu)
