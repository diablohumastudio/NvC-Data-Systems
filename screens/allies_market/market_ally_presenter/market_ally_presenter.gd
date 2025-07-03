@tool
class_name MarketAllyPresenter extends VBoxContainer

@export var ally: Ally : set = _set_ally

func _set_ally(new_value: Ally) -> void:
	ally = new_value
	set_visuals()

func set_visuals() -> void:
	if ally.thumbnail:
		%AllyThumbnail.texture = ally.thumbnail
	%AllyName.text = ally.ally_name
	%AllyPrice.text = str(ally.price)
	if ally.ud_ally.locked == false:
		%AllyPrice.text = "ALREADY BUYED"
		%BuyBtn.disabled = true

func _on_buy_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.UNLOCK_ALLY, Action.PayUnlockAlly.new(ally.id)))
