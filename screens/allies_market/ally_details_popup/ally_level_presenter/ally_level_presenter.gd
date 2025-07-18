class_name AllyLevelPresenter extends MarginContainer

signal level_buyed

var ally_level: AllyLevel
var ally: Ally

func _ready() -> void:
	if ally_level:
		ally = DataFilesLoader.get_allies_from_res_file_by_id(ally_level.ally_id)
		_update_visuals()

func _update_visuals():
	var is_level_unlocked: bool = ally.ud_ally.is_level_unlocked(ally_level.level_id)
	var is_level_buyed: bool = ally.ud_ally.is_level_buyed(ally_level.level_id)
	
	%AllyLevelName.text = ally_level.level_id
	%AllyLevelPrice.text = str(ally_level.price)
	%AllyLevelIsUnlocked.text = str(is_level_unlocked)
	%BuyAllyLevelBtn.disabled = !is_level_unlocked
	%AllyLevelIsBuyed.text = str(is_level_buyed)

func _on_buy_ally_level_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.BUYED_ALLY_LEVEL, Action.PayBuyedAllyLevel.new(ally_level.level_id, ally_level.ally_id)))
	update_all_level_presenters_visuals()

func update_all_level_presenters_visuals():
	level_buyed.emit()
