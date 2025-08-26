## Menu for selecting and launching game worlds and levels
class_name AboutMenu extends Control

func _ready():
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_WORLDS_MAP_MENU)
	%SubmenuSelector.submenu_selected.connect(_on_submenu_selector_submenu_selected)

func _on_submenu_selector_submenu_selected(submenu_background_scene:PackedScene, submenu_popup_scene:PackedScene):
	await %PopupPresenter.display_exit_popup_animation()
	%BackgroundPresenter.display_background_scene(submenu_background_scene)
	%PopupPresenter.display_popup_scene(submenu_popup_scene)

func _on_go_back_button_pressed():
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_MAIN_MENU)
	AudioSystem.post_event(AK.EVENTS.PLAY_GO_BACK)
	%AnimationPlayer.play("go_back_selected")
	var main_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.MAIN_MENU)
	SMS.change_scene(main_menu, {"_entering_from_about_menu": true})
