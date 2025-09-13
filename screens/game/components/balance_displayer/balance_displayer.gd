class_name BalanceDisplayer extends TextureRect

var balance : int = 0

func _ready() -> void:
	_set_balance_label(0)
	GSS.balance_changed.connect(_on_gss_balance_changed)

func _on_gss_balance_changed(_balance: int):
	balance = _balance
	_set_balance_label(balance)

func _set_balance_label(_balance: int):
	%BalanceLabel.text = str(_balance)
