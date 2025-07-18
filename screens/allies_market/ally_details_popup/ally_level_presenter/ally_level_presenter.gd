class_name AllyLevelPresenter extends MarginContainer

signal level_buyed

var ally_level: AllyLevel : set = _set_level
var is_unlocked: bool : set = _set_is_unlocked

func _set_level(new_value: AllyLevel):
	ally_level = new_value
	if ally_level:
		_update_visuals()

func _set_is_unlocked(new_value: bool):
	is_unlocked = new_value
	if is_unlocked:
		_update_visuals()

func _update_visuals():
	var ally: Ally = DataFilesLoader.get_allies_from_res_file_by_id(ally_level.ally_id)
	%AllyLevelName.text = ally_level.level_id
	%AllyLevelPrice.text = str(ally_level.price)
	%AllyLevelIsUnlocked.text = str(ally.ud_ally.is_level_unlocked(ally_level.level_id))
	%AllyLevelIsBuyed.text = str(ally.ud_ally.is_level_buyed(ally_level.level_id))

func _on_buy_ally_level_btn_pressed() -> void:
	var ally: Ally = DataFilesLoader.get_allies_from_res_file_by_id(ally_level.ally_id)
	ACS.set_action(Action.new(Action.TYPES.BUYED_ALLY_LEVEL, Action.PayBuyedAllyLevel.new(ally_level.level_id, ally_level.ally_id)))
	_update_visuals()
	level_buyed.emit()
