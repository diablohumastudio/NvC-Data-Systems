class_name AchievementPresenter2 extends Control

var achievement: AchievementData 
var ud_achievement: UDAchievement

func _ready() -> void:
	_set_visuals()

func _set_visuals():
	if !achievement: return
	
	var porcentage_achived: int =  0
	var total_conditions: int = achievement.conditions.size()
	var achieved_conditions: int = ud_achievement.fullfilled_conditions.size()
	porcentage_achived = int(float(achieved_conditions) / float(total_conditions) * 100)
	
	%NameLabel.text = achievement.achievement_name
	%DescriptionLabel.text = achievement.description
	%ProgressIconBg.value = porcentage_achived
	
