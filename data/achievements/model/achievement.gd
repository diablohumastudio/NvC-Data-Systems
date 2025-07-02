class_name Achievement extends Resource

enum IDs {AchievCompLv2, AchievCompLv2and2p, AchievEnemKillTot5}

@export var id: IDs
@export var achievement_name: String
@export var description: String
@export var reward: int
@export var ud_achievement: UDAchievement : set = _set_ud_achievement

func _set_ud_achievement(new_value:UDAchievement) -> void:
	ud_achievement = new_value
	for saved_ud_achiev in UDS.current_user_data.ud_achievements.ud_achievements:
		if saved_ud_achiev.id == ud_achievement.id:
			ud_achievement = saved_ud_achiev
