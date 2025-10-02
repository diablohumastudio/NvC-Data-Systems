extends Control

var game_char_to_place: PackedScene

func _ready() -> void:
	for add_char_btn: AddGamecharacterBtn in get_tree().get_nodes_in_group("add_game_character_btn"):
		add_char_btn.game_char_selected.connect(_on_add_char_bt_ally_selected)
	for grid_btn: Button in %AlliesGrid:
		grid_btn.pressed.connect(_on_grid_btn_pressed.bind(grid_btn))
	for grid_btn: Button in %EnemiesGrid:
		grid_btn.pressed.connect(_on_grid_btn_pressed.bind(grid_btn))

func _on_add_char_bt_ally_selected(game_char_scene: PackedScene):
	game_char_to_place = game_char_to_place

func _on_grid_btn_pressed(grid_btn: Button):
	grid_btn.add_child(game_char_to_place.instantiate())
