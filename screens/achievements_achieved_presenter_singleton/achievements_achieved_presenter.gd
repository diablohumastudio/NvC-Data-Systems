extends Control

func _ready() -> void:
	var ud_chivements = UDS.current_user_data.ud_achievements.ud_achievements
	for ud_chivement in ud_chivements:
		ud_chivement.achieved.connect(_on_ud_achievement_achieved)

func _on_ud_achievement_achieved(id: Achievement.IDs):
	var achievements: Array[Achievement] = DataFilesLoader.get_achievements_from_res_files()
	var new_achivement_achieved_presenter: AchievementAchievedPresenter
	for achivement in achievements:
		if achivement.id == id:
			new_achivement_achieved_presenter = load("res://screens/achievements_achieved_presenter_singleton/achievement_achieved_presenter/achievement_achieved_presenter.tscn").instantiate()
			new_achivement_achieved_presenter.achievement = achivement
			%AchievementsContainer.add_child(new_achivement_achieved_presenter)
	await get_tree().create_timer(1.5).timeout
	new_achivement_achieved_presenter.queue_free()
