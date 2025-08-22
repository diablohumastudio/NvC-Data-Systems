class_name AchievementsScr extends Control

func _ready() -> void:
	var achievements: Array[AchievementData]
	achievements = DataFilesLoader.get_achievements_from_res_files()
	for child in %AchievementsList.get_children():
		child.queue_free()
	for achievement in achievements:
		var new_achievement_presenter: AchievementPresenter = load("res://screens/achievements_scr/achievement_presenter/achievement_presenter.tscn").instantiate()
		new_achievement_presenter.achievement = achievement
		%AchievementsList.add_child(new_achievement_presenter)

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)
