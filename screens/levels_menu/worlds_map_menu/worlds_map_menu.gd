class_name WorldsMapMenu extends Control

var entering_from_salingrad_summer_levels_menu: bool = false
var entering_from_salingrad_winter_levels_menu: bool = false
	
func _ready() -> void:
	AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_WORLDS_MAP_MENU)
	if entering_from_salingrad_summer_levels_menu:
		%AnimationPlayerTransition.play("goto_stalingrad_summer_level_map_menu", -1, -1.5, true)
	if entering_from_salingrad_winter_levels_menu:
		%AnimationPlayerTransition.play("goto_stalingrad_winter_level_map_menu", -1, -1.5, true)

func _on_go_back_button_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_GO_BACK)
	var main_menu: PackedScene = SLS.get_scene("uid://cflg2ypu25js2")
	SMS.change_scene(main_menu, {"_entering_from_worlds_map_menu": true})

func _on_stalingrad_summer_button_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	var stalingrad_summer_levels_menu: PackedScene = SLS.get_scene("uid://bnl38rkw31r66")
	%AnimationPlayerTransition.play("goto_stalingrad_summer_level_map_menu", -1, 1.5)
	await %AnimationPlayerTransition.animation_finished
	SMS.change_scene(stalingrad_summer_levels_menu)

func _on_stalingrad_winter_button_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_BUTTON_MENU_CLICK2)
	var stalingrad_winter_levels_menu: PackedScene = SLS.get_scene("uid://gci4nehonton")
	%AnimationPlayerTransition.play("goto_stalingrad_winter_level_map_menu", -1, 1.5)
	await %AnimationPlayerTransition.animation_finished
	SMS.change_scene(stalingrad_winter_levels_menu)
