extends Node2D
## Node that manages Wwise audio integration for music and sound effects

var _user_settings : UserSettings 
var music_volume: float: set = _set_music_volume
var sfx_volume: float: set = _set_sfx_volume
@warning_ignore("unused_signal") #signal emited in inherited class objects
signal music_sync_exit

func _set_music_volume(new_volume:float):
	music_volume = new_volume
	Wwise.set_rtpc_value_id(AK.GAME_PARAMETERS.MUSIC_VOLUME, music_volume, null)

func _set_sfx_volume(new_volume:float):
	sfx_volume = new_volume
	Wwise.set_rtpc_value_id(AK.GAME_PARAMETERS.SFX_VOLUME, sfx_volume, null)

func _ready():
	UDS.current_user_changed.connect(_set_settings_menu_values)
	_set_settings_menu_values()
	initialize_music_system()

func _set_settings_menu_values():
	_user_settings = UDS.current_user_data.settings
	music_volume = _user_settings.music_volume
	sfx_volume = _user_settings.sfx_volume

func initialize_music_system() -> void:
	Wwise.post_event_id_callback(AK.EVENTS.PLAY_MUSIC_SWITCH_CONTAINER, AkUtils.AK_MUSIC_SYNC_EXIT ,self, _on_wwise_ak_music_sync_exit)

func _on_wwise_ak_music_sync_exit(data: Dictionary) -> void:
	call_deferred("emit_signal", "music_sync_exit", data )  #call_deferred needed because signal from wwise came from not main thread

func stop_music():
	Wwise.post_event_id(AK.EVENTS.STOP_MUSIC_SWITCH_CONTAINER, self)

func post_event(event_id:int):
	var _event_post_response = Wwise.post_event_id(event_id,self)
	assert(_event_post_response != 0,"Invalid Event ID")
