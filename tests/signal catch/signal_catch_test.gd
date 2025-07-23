extends Control

var my_res : ResSignalEmitter
var res_listener_1: SignalResListener = SignalResListener.new()
var res_listener_2: SignalResListener = SignalResListener.new()

var res_listener_out_1: SignalResListenerOutConection = SignalResListenerOutConection.new()
var res_listener_out_2: SignalResListenerOutConection = SignalResListenerOutConection.new()

var res_listener_out_3: SignalResListenerOutConection = SignalResListenerOutConection.new()

var res_listener_out_4: SignalResListenerOutConection = SignalResListenerOutConection.new()

var test_res_4: Resource = Resource.new()
var test_res_4_1: Resource = Resource.new()

func _ready() -> void:
	my_res = load("res://tests/signal catch/res_signal_emitter/data/my_res_signal_emmiter_file.tres")
	my_res.i_have_emitted.connect(res_listener_out_1.on_my_res_signal_emitter_i_have_emitted)
	my_res.i_have_emitted.connect(res_listener_out_2.on_my_res_signal_emitter_i_have_emitted)
	
	my_res.i_have_emitted.connect(res_listener_out_3.on_my_res_signal_emitter_i_have_emitted.bind(3))
	my_res.i_have_emitted.connect(res_listener_out_3.on_my_res_signal_emitter_i_have_emitted.bind(4))
	
	my_res.i_have_emitted.connect(res_listener_out_4.on_my_res_signal_emitter_i_have_emitted.bind(test_res_4))
	my_res.i_have_emitted.connect(res_listener_out_4.on_my_res_signal_emitter_i_have_emitted.bind(test_res_4_1))
	
func _on_emit_signal_from_res_btn_pressed() -> void:
	my_res.i_have_emitted.emit()
