## Manages de SplashScreen2 scene. [br]
## The scene is a screen designed to appear as the first scene after the splash screen. 
##
## It let the player know that [b]DiabloHumaStudio[/b] company create the game, [br]
## and that for this purpose, the studio used [b]Godot Engine[/b] and [b]WWise Engine[/b].   
class_name SplashScreen2 extends Control

var _is_loading_screen_ready: bool = false
var _is_animation_finished: bool = false

func _on_sls_bank_all_scenes_loaded() -> void:
	_is_loading_screen_ready = true
	_goto_loading_screen()

func _on_animation_player_animation_finished(_anim_name: String):
	_is_animation_finished = true
	_goto_loading_screen()

func _goto_loading_screen() -> void:
	if _is_animation_finished and _is_loading_screen_ready:
		var loading_screen: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.LOADING_SCREEN)
		SMS.change_scene(loading_screen)
