## Manages beautyfull LoadingScreen scene. [br]
## Loads all screens, so don't have to later and game feels fast. 
## 
## Loads asyncronous so the animations keep runing while doing it. [br]
## Very beauty scene with animations so you can feel art while waiting.
class_name LoadingScreen extends Control

var _is_initial_music_segment_played := false
var _are_all_resources_loaded := false

#conect wwise and start loaders loading process
func _ready():
	_is_initial_music_segment_played = true
	#AudioSystem.post_event(AK.EVENTS.SET_MUSIC_SC_LOADING_SCREEN)
	#AudioSystem.music_sync_exit.connect(_on_wwise_audio_system_music_sync_exit,CONNECT_ONE_SHOT,)
	_activate_animated_loaders()

#when every loader finished loading try to go to main_menu
func _activate_animated_loaders() -> void:
	for animated_loader:AnimatedLoader in %AnimatedLoadersContainer.get_children():
		await animated_loader.load()
	_are_all_resources_loaded = true
	_go_to_main_menu()

#when loading screen music finished try to go to main_menu
func _on_wwise_audio_system_music_sync_exit(_event_data:Dictionary):
	_is_initial_music_segment_played = true
	_go_to_main_menu()

#only when every loader finished loading AND loading screen music finishes, it goes to main menu
func _go_to_main_menu() -> void:
	if _is_initial_music_segment_played and _are_all_resources_loaded:
		var main_menu : PackedScene = SLS.get_scene(GC.SCREENS_UIDS.MAIN_MENU)
		SMS.change_scene(main_menu)
