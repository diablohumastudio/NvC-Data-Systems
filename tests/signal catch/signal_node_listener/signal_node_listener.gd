class_name SignalNodeListener extends Label

@export var my_res_signal_emitter: ResSignalEmitter

func _ready() -> void:
	my_res_signal_emitter = load("res://tests/signal catch/res_signal_emitter/data/my_res_signal_emmiter_file.tres")
	my_res_signal_emitter.i_have_emitted.connect(on_my_res_signal_emitter_i_have_emitted)

func on_my_res_signal_emitter_i_have_emitted():
	modulate = Color.SEA_GREEN
