extends Control

enum TYPES {BOUNCE, CIRCULAR}

var anim_type: TYPES = TYPES.CIRCULAR

var parameter: String 
var parameter_amount: float = 0

func _ready() -> void:
	parameter = "parameters/Blend2/blend_amount"
	#parameter = "parameters/Add2/add_amount"

func _on_circular_anim_btn_pressed() -> void:
	anim_type = TYPES.CIRCULAR

func _on_bounce_anim_btn_pressed() -> void:
	anim_type = TYPES.BOUNCE

func _on_modulate_pulse_btn_toggled(toggled_on: bool) -> void:
	parameter_amount = 1 if toggled_on else 0
	_set_parameter()

func _on_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		parameter_amount = %VSlider.value
		_set_parameter()

func _set_parameter():
	%AnimationTree.set(parameter, parameter_amount)

func _on_modulate_pulse_btn_item_selected(index: int) -> void:
	match index:
		0:
			parameter_amount = 0
		1:
			parameter_amount = 0.5
		2:
			parameter_amount = 1
	_set_parameter()
