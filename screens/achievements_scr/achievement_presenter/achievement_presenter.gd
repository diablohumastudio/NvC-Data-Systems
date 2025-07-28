class_name AchievementPresenter extends HBoxContainer

@export var achievement: Achievement: set = _set_achievement

func _set_achievement(new_value: Achievement):
	achievement = new_value
	var porcentage_achived: int =  0
	var total_conditions: int = achievement.conditions.size()
	var achieved_conditions: int = achievement.get_saved_ud_achievement().fullfilled_conditions.size()
	porcentage_achived = int(float(achieved_conditions) / float(total_conditions) * 100)
	%AchievName.text = achievement.achievement_name
	%PorcentageFullfiled.text = "(" + str(achieved_conditions) + "/" + str(total_conditions) + "=" + str(porcentage_achived) + "%)" 
	%AchievFullfilled.text = str(achievement.get_saved_ud_achievement().is_achieved)
	if achievement.get_saved_ud_achievement().is_achieved:
		%AchievFullfilled.modulate = Color.GREEN
