class_name Game extends Control

var level: Level 

func _ready() -> void:
	initializate_components()
	_conect_components()

func initializate_components():
	%LevelNamePresenter.level = level
	%DbugWinBtn.level = level

func _conect_components():
	(%AlliesSelector as AlliesSelector).ally_selected.connect(_on_allies_selector_ally_selected)
	(%TerrainGrid as TerrainGrid).ally_placed.connect(_on_terrain_grid_ally_placed)
	(%RemoveAllyButton as RemoveAllyBtn).pressed.connect(on_remove_ally_btn_pressed)
	(%DbugWinBtn as DBugWinBtn).game_won.connect(on_win_btn_game_won)

func on_remove_ally_btn_pressed():
	%TerrainGrid.set_removing_state( %RemoveAllyButton.button_pressed)

func _on_terrain_grid_ally_placed(ally: Ally):
	%TerrainGrid.ally_to_place = null
	%AlliesSelector.time_block_card(ally)

func _on_allies_selector_ally_selected(ally: Ally):
	%TerrainGrid.ally_to_place = ally

func on_win_btn_game_won() -> void:
	%GameWonPopUp.show_win_presentation()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)
