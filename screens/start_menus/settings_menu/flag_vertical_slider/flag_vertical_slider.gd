class_name FlagVerticalSlider extends VolumeSlider
## Custom vertical slider for controlling audio volume with visual feedback

@export var grabber_texture: Texture2D
@export var grabber_highlight_texture: Texture2D
@export var grabber_muted_texture: Texture2D
@export var grabber_muted_highlight_texture: Texture2D

func _ready():
	_set_user_values()
	%AnimationPlayer.play("appear")

func _value_changed(new_value: float):
	super(new_value)
	_toogle_disable_textures(new_value == 0)

func _toogle_disable_textures(is_disabled: bool) -> void:
	if is_disabled:
		self["theme_override_icons/grabber"] = grabber_muted_texture
		self["theme_override_icons/grabber_highlight"] = grabber_muted_highlight_texture
	else:
		self["theme_override_icons/grabber"] = grabber_texture
		self["theme_override_icons/grabber_highlight"] = grabber_highlight_texture
