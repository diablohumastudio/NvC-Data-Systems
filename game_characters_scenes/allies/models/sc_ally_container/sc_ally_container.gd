class_name ScAllyContainer extends Node2D

var ally: Ally
var level: AllyLevel: set = _set_level

func _set_level(new_value: AllyLevel):
	level = new_value 
	%ScAlly.free()
	var new_sc_ally: ScAlly = level.scene.instantiate()
	new_sc_ally.name = "ScAlly"
	add_child(new_sc_ally)

func _ready() -> void:
	($ScAlly/AllyHUD/AllyUpgradeMenu as AllyUpgradeMenu).level_changed.connect(on_ally_upgrade_menu_level_changed)
	($ScAlly/AllyHUD/SelectAllyBtn as TextureButton).pressed.connect(on_select_ally_btn_pressed)

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state: 
		self.queue_free()
		GSS.removing_ally_state = false
	else: $ScAlly/AllyHUD/AllyUpgradeMenu.visible = true
