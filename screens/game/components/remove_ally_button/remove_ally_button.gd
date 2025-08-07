class_name RemoveAllyBtn extends TextureButton

func _ready() -> void:
	GSS._removing_ally_state_changed.connect(_on_GSS_removing_ally_state_changed)

func _on_GSS_removing_ally_state_changed(state: bool):
	set_pressed_no_signal(state)

func _toggled(toggled_on: bool) -> void:
	if toggled_on: GSS.removing_ally_state = true
	else : GSS.removing_ally_state = false
