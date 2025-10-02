class_name ALDAnimatedSprite2D extends AnimatedSprite2D

@export var levels_modifiers_textures: Dictionary[String, SpriteFrames]
var buyed_levels: Array[AllyLevelData]

func _ready() -> void:
	#this kind of node is dependant on an sc_ally and will work inside of it directly (no instance scene in the middle)
	add_to_group(str(owner))

func set_levels(_levels: Array[AllyLevelData]):
	buyed_levels = _levels
	update_visuals()

func update_visuals():
	for buyed_level in buyed_levels:
		if levels_modifiers_textures.has(buyed_level.id):
			sprite_frames = levels_modifiers_textures[buyed_level.id]
