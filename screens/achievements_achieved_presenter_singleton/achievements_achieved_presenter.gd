extends Control

var achivement_achieved_presenter_pksc: PackedScene = load("res://screens/achievements_achieved_presenter_singleton/achievement_achieved_presenter/achievement_achieved_presenter.tscn")

func _ready() -> void:
	conect_ud_achievements()
	UDS.current_user_changed.connect(_on_UDS_current_user_changed)

func _on_UDS_current_user_changed():
	conect_ud_achievements()

func conect_ud_achievements():
	var ud_chivements = UDS.get_property(UDS.PROPERTIES.UD_ACHIEVEMENTS).ud_achievements
	for ud_chivement in ud_chivements as Array[UDAchievement]:
		if !ud_chivement.achieved.is_connected(_on_ud_achievement_achieved):
			ud_chivement.achieved.connect(_on_ud_achievement_achieved)

func _on_ud_achievement_achieved(id: Achievement.IDs):
	var achievement = DataFilesLoader.get_achiev_from_res_file_by_id(id)
	var new_achivement_achieved_presenter: AchievementAchievedPresenter
	new_achivement_achieved_presenter = achivement_achieved_presenter_pksc.instantiate()
	%AchievementsContainer.add_child(new_achivement_achieved_presenter)
	new_achivement_achieved_presenter.achievement = achievement
	await get_tree().create_timer(1.5).timeout
	new_achivement_achieved_presenter.queue_free()
