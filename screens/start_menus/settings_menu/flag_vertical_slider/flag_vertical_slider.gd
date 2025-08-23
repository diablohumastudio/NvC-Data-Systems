class_name FlagVerticalSlider extends VSlider
## Custom vertical slider for controlling audio volume with visual feedback

enum types { music, sfx }
@export var type: types = types.music

@export var grabber_texture: Texture2D
@export var grabber_highlight_texture: Texture2D
@export var grabber_muted_texture: Texture2D
@export var grabber_muted_highlight_texture: Texture2D

func _ready():
	%AnimationPlayer.play("appear")
	#if type == types.music: value = UserDataManager.user_data.user_settings.music_volume_value
	#if type == types.sfx: value = UserDataManager.user_data.user_settings.sfx_volume_value
#
#func _value_changed(new_value: float):
	#_toogle_disable_textures(new_value == 0)
#
	#if type == types.music: 
		#UserDataManager.user_data.user_settings.music_volume_value = value
		#AudioSystem.music_volume = new_value
	#if type == types.sfx: 
		#UserDataManager.user_data.user_settings.sfx_volume_value = value 
		#AudioSystem.sfx_volume = new_value
#
	#UserDataManager.save_user_data_to_disk()

func _toogle_disable_textures(is_disabled: bool) -> void:
	if is_disabled:
		self["theme_override_icons/grabber"] = grabber_muted_texture
		self["theme_override_icons/grabber_highlight"] = grabber_muted_highlight_texture
	else:
		self["theme_override_icons/grabber"] = grabber_texture
		self["theme_override_icons/grabber_highlight"] = grabber_highlight_texture
