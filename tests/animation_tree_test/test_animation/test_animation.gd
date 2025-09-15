extends Control

enum TYPES {BOUNCE, CIRCULAR}

var anim_type: TYPES = TYPES.CIRCULAR

func _on_circular_anim_btn_pressed() -> void:
	anim_type = TYPES.CIRCULAR

func _on_bounce_anim_btn_pressed() -> void:
	anim_type = TYPES.BOUNCE

func _on_modulate_pulse_btn_toggled(toggled_on: bool) -> void:
	var add_amount: int = 1 if toggled_on else 0
	if toggled_on: %AnimationTree.set("parameters/Add2/add_amount", add_amount)
	else: %AnimationTree.set("parameters/Add2/add_amount", add_amount)
