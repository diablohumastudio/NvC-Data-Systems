class_name Game extends Control

var level: Level : set = _set_level

func _set_level(new_value: Level) -> void:
	level = new_value
	%LevelNamePresenter.text = level.level_name

func _ready() -> void:
	(%AlliesSelector as AlliesSelector).ally_selected.connect(_on_allies_selector_ally_selected)
	(%TerrainGrid as TerrainGrid).ally_placed.connect(_on_terrain_grid_ally_placed)
	(%RemoveAllyButton as RemoveAllyBtn).pressed.connect(on_remove_ally_btn_pressed)

func on_remove_ally_btn_pressed():
	%TerrainGrid.set_removing_state( %RemoveAllyButton.button_pressed)

func _on_terrain_grid_ally_placed(ally: Ally):
	%AlliesSelector.time_block_card(ally)

func _on_allies_selector_ally_selected(ally: Ally):
	%TerrainGrid.ally_to_place = ally

func _on_win_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD_ALL_CANONS, Action.PayLvlComplAllCanons.new(level.id, %GameStats.canons_alive)))
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, Action.PayLvCompl.new(level.id)))

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)
