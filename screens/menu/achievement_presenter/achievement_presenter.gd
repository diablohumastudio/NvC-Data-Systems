class_name AchievementPresenter extends HBoxContainer

@export var achievement: Achievement: set = _set_achievement

func _set_achievement(new_value: Achievement):
	achievement = new_value
	%AchievName.text = achievement.achievement_name
	%AchievFullfilled.text = str(achievement.ud_achievement.is_achieved)
	if achievement.ud_achievement.is_achieved:
		%AchievFullfilled.modulate = Color.GREEN
