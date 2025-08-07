class_name Game extends Control

var level: Level 

func _ready() -> void:
	initializate_components()
	_conect_components()

func initializate_components():
	%LevelNamePresenter.level = level
	%DbugWinBtn.level = level

func _conect_components():
	(%RemoveAllyButton as RemoveAllyBtn).pressed.connect(on_remove_ally_btn_pressed)

func on_remove_ally_btn_pressed():
	%TerrainGrid.set_removing_state( %RemoveAllyButton.button_pressed)

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)
