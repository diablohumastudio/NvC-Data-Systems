class_name VolumeSlider extends Slider

enum types { music, sfx }
@export var type: types = types.music

func _set_user_values():
	if type == types.music: value = UDS.get_property(UDS.PROPERTIES.MUSIC_VOLUME)
	if type == types.sfx: value = UDS.get_property(UDS.PROPERTIES.SFX_VOLUME)

func _value_changed(new_value: float) -> void:
	value = new_value
	if type == types.music: 
		UDS.current_user_data.settings.music_volume = value
		AudioSystem.music_volume = new_value
	if type == types.sfx: 
		UDS.current_user_data.settings.sfx_volume = value 
		AudioSystem.sfx_volume = new_value

	UDS.save_user_data_to_disk()
