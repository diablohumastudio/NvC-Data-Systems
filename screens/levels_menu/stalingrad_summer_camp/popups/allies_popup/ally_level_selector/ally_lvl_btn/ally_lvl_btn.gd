class_name AllyLvlBtn extends TextureButton

@export var ally_level : AllyLevelData
var unlocked : bool = false
var applied : bool = false

func _ready() -> void:
	_set_texture_and_availabily()

func _set_texture_and_availabily() -> void:
	if !ally_level or !ally_level.get_saved_ud_ally_level(): return
	unlocked = ally_level.get_saved_ud_ally_level().unlocked
	if !unlocked:
		disabled = true
	else:
		pass
	
	
