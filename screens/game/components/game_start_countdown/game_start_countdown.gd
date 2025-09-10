class_name GameStartCountDown extends Control

signal start_countdown_finished
signal played_defend_sound

@onready var animation_player = %AnimationPlayer

func start_count_down():
	visible = true
	animation_player.play("countdown")
	AudioSystem.post_event(AK.EVENTS.PLAY_COUNTDOWN_LEVEL_START)

func _on_animation_player_animation_finished(_anim_name):
	visible = false
	start_countdown_finished.emit()

#called by the animation player so sound is exactly when it should
func play_defend_level_start_sound():
	played_defend_sound.emit()
	AudioSystem.post_event(AK.EVENTS.PLAY_DEFEND_LEVEL_START)
