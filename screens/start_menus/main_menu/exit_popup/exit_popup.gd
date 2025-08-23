## Popup dialog that confirms if the user wants to exit the game
class_name ExitPopup
extends Control

## Reference to the animation player for appear/disappear animations
@onready var animation_player = $AnimationPlayer

## Handles the "Yes" button press, confirming exit
func _on_yes_button_pressed():
	close_app()

func close_app():
	get_tree().quit()

## Handles the "No" button press, canceling exit
func _on_no_button_pressed():
	disappear()

func disappear():
	animation_player.play("dissapear")
	await animation_player.animation_finished
	visible = false
	
## Plays the appear animation when showing the popup
func appear():
	visible = true
	animation_player.play("appear")
