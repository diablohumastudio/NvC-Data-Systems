class_name AllyLvlBtn extends TextureButton
@export var buyed_texture : Texture
@export var ally_level : AllyLevelData
var unlocked : bool = false
var buyed : bool = false #: set = _set_buyed

signal upgraded_to_level(level: AllyLevelData)

func _ready() -> void:
	var acs: ActionConditionSystem = ActionConditionSystem.new()
	ally_level.set_unlock_conditions_by_acs_instance(acs)
	_set_texture_and_availabily()
	ally_level.just_unlocked.connect(_set_texture_and_availabily)
	ally_level.just_buyed.connect(_set_texture_and_availabily)

#func _set_buyed(new_value:bool) -> void:
	#buyed = new_value
	#_set_texture_and_availabily()

func _set_texture_and_availabily() -> void:
	if !ally_level or !ally_level.get_saved_ud_ally_level(): return
	if ally_level.unlockd_by_default:
		unlocked = true
	else:
		unlocked = ally_level.get_saved_ud_ally_level().unlocked
	buyed = ally_level.get_saved_ud_ally_level().buyed
	
	if buyed:
		texture_disabled = buyed_texture
		modulate = Color(1,1,1,0.5)
	
	if !unlocked or buyed:
		disabled = true
	else:
		pass
	
	
