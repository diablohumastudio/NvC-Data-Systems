class_name AllyLevelDependentSprite2D extends Sprite2D

@export var levels_modifiers_textures: Dictionary[AllyLevel, Texture2D]

func _ready() -> void:
	add_to_group(str(owner))

func set_levels(levels: Array[AllyLevel]):
	printt("el boton fue presionado y la funcion del nodo activada en un nodo del aliado: ", owner)
	for level in levels:
		if levels_modifiers_textures.has(level):
			texture = levels_modifiers_textures[level]
