class_name StalingradSummerCamp extends Control

@onready var barracks_popup: Control = $BarracksPopup

func _on_barracks_pressed() -> void:
	barracks_popup.show_popup()

func _on_texture_button_2_pressed() -> void:
	barracks_popup.hide_popup()

func _on_go_back_button_pressed() -> void:
	var stalingrad_summer_levels_menu : PackedScene = SLS.get_scene(GC.SCREENS_UIDS.STALINGRAD_SUMMER_LEVELS_MENU)
	SMS.change_scene(stalingrad_summer_levels_menu, {"entering_from_stalingrad_summer_camp": true})
