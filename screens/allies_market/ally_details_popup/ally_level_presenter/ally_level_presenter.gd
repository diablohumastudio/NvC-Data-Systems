class_name AllyLevelPresenter extends MarginContainer

var level: AllyLevel : set = _set_level
var is_unlocked: bool : set = _set_is_unlocked

func _set_level(new_value: AllyLevel):
	level = new_value
	if level:
		_update_visuals()

func _set_is_unlocked(new_value: bool):
	is_unlocked = new_value
	if is_unlocked:
		_update_visuals()

func _update_visuals():
	%AllyLevelName.text = level.level_id
	%AllyLevelPrice.text = str(level.price)
	%AllyLevelIsUnlocked.text = str(is_unlocked)

func _on_buy_ally_level_btn_pressed() -> void:
	print(level.locked)
	level.buyed = true
