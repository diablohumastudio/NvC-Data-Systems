## Main menu class that handles navigation to other menus and exit functionality
class_name MainMenu extends Control

var _entering_from_games_menu: bool = false
var _entering_from_settings_menu: bool = false
var _entering_from_worlds_map_menu: bool = false

func _ready():
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_MAIN_MENU)

func _initial_setup():
	if _entering_from_games_menu:
		%MenusTransitionAnimationPlayer.play_backwards("goto_about_menu")
		%InitialAnimationPlayer.play("start_from_games_menu")
	if _entering_from_settings_menu:
		%MenusTransitionAnimationPlayer.play_backwards("goto_settings_menu")
		%InitialAnimationPlayer.play("start_from_games_menu")
	if _entering_from_worlds_map_menu:
		%MenusTransitionAnimationPlayer.play("goto_worlds_map_menu",-1, -3, true)
		%InitialAnimationPlayer.play("start_from_games_menu")

func _on_go_to_settings_menu_button_pressed():
	await get_tree().create_timer(0.2).timeout #0.2 is half of start_player "start_pressed" animation conected in button script
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_SETTINGS_MENU)
	var settings_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.SETTINGS_MENU)
	%MenusTransitionAnimationPlayer.callv("play", ["goto_settings_menu"])
	await %MenusTransitionAnimationPlayer.animation_finished
	SMS.change_scene(settings_menu)

func _on_go_to_worlds_map_menu_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout #0.2 is half of start_player "start_pressed" animation conected in button script
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_WORLDS_MAP_MENU)
	var worlds_map_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.WORLDS_MAP_MENU)
	%MenusTransitionAnimationPlayer.callv("play", ["goto_worlds_map_menu", -1, 3])
	await %MenusTransitionAnimationPlayer.animation_finished
	SMS.change_scene(worlds_map_menu)

func _on_go_to_about_menu_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout #0.2 is half of start_player "start_pressed" animation conected in button script
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_WORLDS_MAP_MENU)
	var games_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.GAMES_MENU)
	%MenusTransitionAnimationPlayer.callv("play", ["goto_about_menu"])
	await %MenusTransitionAnimationPlayer.animation_finished
	SMS.change_scene(games_menu)

func _on_go_to_market_button_pressed():
	#AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	pass

func handle_mobile_go_back():
	if %ExitPopup.visible == true:
		return
	%InputControl.disable()
	%ExitPopup.appear()

func _on_exit_popup_hidden():
	%InputControl.enable()
