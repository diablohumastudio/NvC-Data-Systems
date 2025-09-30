class_name AllyLvlBtn extends TextureButton

@export var ally_level : AllyLevelData
var unlocked : bool = false
var applied : bool = false

func _ready() -> void:
	_set_texture_and_availabily()

func _set_texture_and_availabily() -> void:
	unlocked = ally_level.unlockd_by_default
	if !unlocked:
		disabled = true
	else:
		pass
	
	
