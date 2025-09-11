class_name AccountAndAchievementsPopup extends Control

signal closed

func _on_account_button_pressed() -> void:
	%AccountMenu.visible = true
	%AchievementsMenu.visible = false

func _on_achievements_button_pressed() -> void:
	%AccountMenu.visible = false
	%AchievementsMenu.visible = true

func _on_account_menu_create_new_user_btn_pressed() -> void:
	%DoubleMenuWoodenPopup.hide()
	%CreateNewUserPopup.show()

func _on_create_new_user_popup_accept_btn_pressed() -> void:
	%DoubleMenuWoodenPopup.show()
	%CreateNewUserPopup.hide()

func _on_create_new_user_popup_cancel_btn_pressed() -> void:
	%DoubleMenuWoodenPopup.show()
	%CreateNewUserPopup.hide()

func _on_close_button_pressed() -> void:
	dissapear()

func dissapear():
	%AnimationPlayer.play("dissapear")
	await %AnimationPlayer.animation_finished
	hide()
	closed.emit()

func appear():
	show()
	%AnimationPlayer.play("appear")
