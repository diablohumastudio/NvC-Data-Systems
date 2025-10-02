class_name AddGamecharacterBtn extends Button

signal game_char_selected(ally_scene: PackedScene)

@export_file var game_char_scene_path: String = "res://game_characters_scenes/"
var game_char_scene: PackedScene

func _ready() -> void:
	add_to_group("add_game_character_btn")
	game_char_scene = load(game_char_scene_path)

func _on_pressed() -> void:
	game_char_selected.emit(game_char_scene)
