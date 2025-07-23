extends Control

var my_res : ResSignalEmitter
var res_listener_1: SignalResListener = SignalResListener.new()
var res_listener_2: SignalResListener = SignalResListener.new()

func _ready() -> void:
	my_res = load("res://tests/signal catch/res_signal_emitter/data/my_res_signal_emmiter_file.tres")

func _on_emit_signal_from_res_btn_pressed() -> void:
	my_res.i_have_emitted.emit()
