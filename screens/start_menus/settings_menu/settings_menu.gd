## Menu for managing game audio settings including music and SFX
class_name SettingsMenu extends Control

func _on_go_back_button_pressed():
	#AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_SETTINGS_MENU)
	var main_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.MAIN_MENU)
	main_menu._entering_from_settings_menu = true
	SMS.change_scene(main_menu)
