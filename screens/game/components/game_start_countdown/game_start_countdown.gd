class_name GameStartCountDown extends Control

@onready var animation_player = %AnimationPlayer

func start_count_down():
	visible = true
	animation_player.play("countdown")
	AudioSystem.post_event(AK.EVENTS.PLAY_COUNTDOWN_LEVEL_START)

func _on_animation_player_animation_finished(_anim_name):
	visible = false
	AudioSystem.post_event(AK.EVENTS.PLAY_DEFEND_LEVEL_START)
