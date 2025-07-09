class_name ScAlly extends GameCharacter

var level: int = 1 : set = _set_level
var levels: Array
var ally: Ally: set = _set_ally

func _set_level(new_value):
	level = new_value
	set_name_and_level()

func _set_ally(new_value):
	ally = new_value
	set_name_and_level()

func set_name_and_level():
	%AllyNameAndLevelLabel.text = "Ally of type:\n" + ally.ally_name + "\n is in Level " + str(level)
