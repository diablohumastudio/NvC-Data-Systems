class_name GameWonPopUp extends ColorRect

func _ready() -> void:
	GSS._game_just_won.connect(on_GCC_game_just_won)

func on_GCC_game_just_won():
	show()
	%AnimationPlayer.play("show_banner")
