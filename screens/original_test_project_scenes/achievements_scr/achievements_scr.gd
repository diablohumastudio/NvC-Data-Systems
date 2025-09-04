class_name AchievementsScr extends Control

const achievement_achieved_presenter_pksc: PackedScene = preload("uid://dp353oa1f38v3")

func _ready() -> void:
	var achievements: Array[AchievementData]
	achievements = DataFilesLoader.get_achievements_from_res_files()
	for child in %AchievementsList.get_children():
		child.queue_free()
	for achievement in achievements:
		var new_achievement_presenter: AchievementPresenter = achievement_achieved_presenter_pksc.instantiate()
		new_achievement_presenter.achievement = achievement
		%AchievementsList.add_child(new_achievement_presenter)

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.MENU))
