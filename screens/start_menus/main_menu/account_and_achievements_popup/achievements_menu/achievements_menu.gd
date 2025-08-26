class_name AchievementsMenu extends Control

func _ready() -> void:
	var achievements: Array[AchievementData]
	achievements = DataFilesLoader.get_achievements_from_res_files()
	for child in %AchievementsContainer.get_children():
		child.queue_free()
	for achievement in achievements:
		var new_achievement_presenter: AchievementPresenter2 = load("uid://cyy4hbmuetvi3").instantiate()
		new_achievement_presenter.achievement = achievement
		%AchievementsContainer.add_child(new_achievement_presenter)
