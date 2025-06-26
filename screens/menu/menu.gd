class_name Menu extends Control

func _ready() -> void:
	var achievements = _get_achievements_from_res_files()
	for achievement in achievements:
		var new_achievement_presenter: AchievementPresenter = load("res://screens/menu/achievement_presenter/achievement_presenter.tscn").instantiate()
		new_achievement_presenter.achievement = achievement
		%AchievementsContainer.add_child(new_achievement_presenter)

func _on_save_btn_pressed() -> void:
	UserDataSystem.save_to_disk()

func _get_achievements_from_res_files() -> Array[Achievement]:
	var achievements: Array[Achievement]
	var dir := DirAccess.open("res://data/achievements/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: Achievement = load(dir.get_current_dir() + "/" + file)
		achievements.append(ud_level.duplicate())
	return achievements
