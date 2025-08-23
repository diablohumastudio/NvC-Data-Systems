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
	var main_menu: MainMenu = SLS.get_scene("uid://cflg2ypu25js2").instantiate()
	main_menu._entering_from_worlds_map_menu = true
	var menus_container:SceneContainer = SMS.get_container("Main") as SceneContainer
	menus_container.goto_scene(main_menu,SM.ANIMATIONS.NONE,SM.ANIMATIONS.NONE)

func _on_stalingrad_summer_button_pressed() -> void:
	var stalingrad_summer_levels_menu: StalingradSummerLevelsMenu = SLS.get_scene("uid://bnl38rkw31r66").instantiate()
	var menus_container:SceneContainer = SMS.get_container("Main") as SceneContainer
	%AnimationPlayerTransition.play("goto_stalingrad_summer_level_map_menu", -1, 1.5)
	await %AnimationPlayerTransition.animation_finished
	menus_container.goto_scene(stalingrad_summer_levels_menu,SM.ANIMATIONS.NONE,SM.ANIMATIONS.NONE)

func _on_stalingrad_winter_button_pressed() -> void:
	var stalingrad_winter_levels_menu: StalingradWinterLevelsMenu = SLS.get_scene("uid://gci4nehonton").instantiate()
	var menus_container:SceneContainer = SMS.get_container("Main") as SceneContainer
	%AnimationPlayerTransition.play("goto_stalingrad_winter_level_map_menu", -1, 1.5)
	await %AnimationPlayerTransition.animation_finished
	menus_container.goto_scene(stalingrad_winter_levels_menu,SM.ANIMATIONS.NONE,SM.ANIMATIONS.NONE)
