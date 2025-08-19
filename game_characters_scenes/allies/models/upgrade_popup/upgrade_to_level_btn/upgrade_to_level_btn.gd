class_name UpgradeToLevelButton extends Button

signal upgraded_to_level(level: AllyLevel)

var level: AllyLevel: set = _set_level

func _set_level(new_value: AllyLevel):
	level = new_value.duplicate()

func _ready():
	text = "Upgrade to level: " + level.level_id
	set("theme_override_font_sizes/font_size", 35)
	_undate_colors()

func _undate_colors():
	if level.in_game_unlocked == true:
		modulate = Color.GREEN
	if level.in_game_buyed == true: 
		modulate = Color.BLUE

func _on_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.IN_GAME_BUYED_ALLY_LEVEL, PayInGameBuyedAllyLevel.new(level.level_id, level.ally_id)))
	level.in_game_buyed = true
	upgraded_to_level.emit(level)
