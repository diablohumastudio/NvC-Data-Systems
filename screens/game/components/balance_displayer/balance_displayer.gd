class_name BalanceDisplayer extends TextureRect

var balance : int = 0

func _ready() -> void:
	_set_balance_label(0)
	GSS.balance_changed.connect(_on_gss_balance_changed)

func _on_gss_balance_changed(balance: int):
	_set_balance_label(balance)

func _set_balance_label(balance: int):
	%BalanceLabel.text = str(balance)
