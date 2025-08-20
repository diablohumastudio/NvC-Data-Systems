class_name UpgradeToLevelButton extends Button

signal upgraded_to_level(level: AllyLevel)

var level: AllyLevel: set = _set_level
var acs: ActionConditionSystem: set = _set_acs

func _set_acs(new_value):
	acs = new_value
	level.set_in_game_unlock_conditions_by_acs_instance(acs)

func _set_level(new_value: AllyLevel):
	level = new_value.duplicate()

func _ready():
	text = "Upgrade to level: " + level.level_id
	set("theme_override_font_sizes/font_size", 35)
	_undate_state_visuals()

func _undate_state_visuals():
	if level.in_game_unlocked == false and !level.unlockd_by_default:
		disabled = true
	if level.in_game_unlocked == true and level.get_saved_ud_ally_level().unlocked:
		disabled = false
		modulate = Color.GREEN
	if level.in_game_buyed == true: 
		modulate = Color.BLUE

func _on_pressed() -> void:
	acs.set_action(Action.new(Action.TYPES.IN_GAME_BUYED_ALLY_LEVEL, PayInGameBuyedAllyLevel.new(level.level_id, level.ally_id)))
	level.in_game_buyed = true
	upgraded_to_level.emit(level)
