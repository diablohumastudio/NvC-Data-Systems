class_name Game extends Control

var level: Level 

func _ready() -> void:
	initializate_components()

func initializate_components():
	%LevelNamePresenter.level = level
	%DbugWinBtn.level = level

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)
