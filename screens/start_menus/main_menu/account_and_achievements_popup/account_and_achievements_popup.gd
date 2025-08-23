class_name AccountAndAchievementsPopup extends Control


func _on_account_button_pressed() -> void:
	$MenuContainer/AccountMenu.visible = true
	$MenuContainer/AchievementsMenu.visible = false


func _on_achievements_button_pressed() -> void:
	$MenuContainer/AccountMenu.visible = false
	$MenuContainer/AchievementsMenu.visible = true
