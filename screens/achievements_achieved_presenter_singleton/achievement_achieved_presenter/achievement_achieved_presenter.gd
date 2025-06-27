class_name AchievementAchievedPresenter extends VBoxContainer

@export var achievement: Achievement : set = _set_achievement

func _set_achievement(new_value: Achievement):
	achievement = new_value
	%AchievementName.text = achievement.achievement_name
