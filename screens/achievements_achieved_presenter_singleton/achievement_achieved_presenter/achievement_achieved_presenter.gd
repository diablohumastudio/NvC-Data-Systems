class_name AchievementAchievedPresenter extends VBoxContainer

@export var achievement: AchievementData : set = _set_achievement

func _set_achievement(new_value: AchievementData):
	achievement = new_value
	%AchievementName.text = achievement.achievement_name
