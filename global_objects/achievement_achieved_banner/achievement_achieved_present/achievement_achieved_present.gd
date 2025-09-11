class_name AchievementAchivedPresent extends Control

@export var achievement: AchievementData : set = _set_achievement

func _set_achievement(new_value: AchievementData):
	achievement = new_value
	%NameLabel.text = achievement.achievement_name
	%DescriptionLabel.text = achievement.description
