class_name AllyLvlBtn extends TextureButton

@export var buyed_texture : Texture
@export var ally_level : AllyLevelData
var unlocked : bool = false
var buyed : bool = false : set = _set_buyed

func _ready() -> void:
	_set_texture_and_availabily()

func _set_buyed(new_value:bool) -> void:
	buyed = new_value
	_set_texture_and_availabily()

func _set_texture_and_availabily() -> void:
	if !ally_level or !ally_level.get_saved_ud_ally_level(): return
	#unlocked = ally_level.get_saved_ud_ally_level().unlocked
	unlocked = ally_level.unlockd_by_default
	
	if buyed:
		texture_disabled = buyed_texture
		modulate = Color(1,1,1,0.5)
	
	if !unlocked or buyed:
		disabled = true
	else:
		pass
	
	
