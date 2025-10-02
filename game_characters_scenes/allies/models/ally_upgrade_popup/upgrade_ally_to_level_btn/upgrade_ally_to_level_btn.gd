class_name UpgradeToLevelButton extends Button

signal upgraded_to_level(level: AllyLevelData)

var level: AllyLevelData: set = _set_level
var acs: ActionConditionSystem: set = _set_acs

func _set_acs(new_value):
	acs = new_value
	level.set_in_game_unlock_conditions_by_acs_instance(acs)

func _set_level(new_value: AllyLevelData):
	level = new_value.duplicate()

func _ready():
	text = "Upgrade to level: " + level.id
	set("theme_override_font_sizes/font_size", 35)
	_update_state_visuals()
	level.in_game_just_unlocked.connect(_update_state_visuals)
	level.in_game_just_buyed.connect(_update_state_visuals)

func _update_state_visuals():
	var buyed: bool = level.get_saved_ud_ally_level().buyed
	if (level.in_game_unlocked and buyed) or (level.unlockd_by_default and buyed):
		disabled = false
		modulate = Color.GREEN
	else:
		disabled = true
		modulate = Color.WHITE
	if level.in_game_buyed == true: 
		disabled = true
		modulate = Color.DIM_GRAY

func _on_pressed() -> void:
	acs.set_action(Action.new(Action.TYPES.IN_GAME_BUYED_ALLY_LEVEL, PayInGameBuyedAllyLevel.new(level)))
	upgraded_to_level.emit(level)
