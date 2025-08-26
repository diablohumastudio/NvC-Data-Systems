class_name AccountAndAchievementsPopup extends Control


func _on_account_button_pressed() -> void:
	$MenuContainer/AccountMenu.visible = true
	$MenuContainer/AchievementsMenu.visible = false

func _on_achievements_button_pressed() -> void:
	$MenuContainer/AccountMenu.visible = false
	$MenuContainer/AchievementsMenu.visible = true

func _on_close_button_pressed() -> void:
	%AnimationPlayer.play("dissapear")
	await %AnimationPlayer.animation_finished
	hide()

func appear():
	show()
	%AnimationPlayer.play("appear")
