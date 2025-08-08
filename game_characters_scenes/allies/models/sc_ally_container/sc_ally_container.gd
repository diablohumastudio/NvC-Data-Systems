class_name ScAllyContainer extends Node2D

var level: AllyLevel: set = _set_level
var ally: Ally
var hp: int

func _set_level(new_value: AllyLevel):
	level = new_value
	if is_inside_tree():
		set_text_and_scene()

func _ready() -> void:
	%AllyUpgradeMenu.level_changed.connect(on_ally_upgrade_menu_level_changed)
	set_text_and_scene()

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func set_text_and_scene():
	%AllyNameAndLevelLabel.text = "Type: " + ally.ally_name + "\n Level " + str(level.level_id)

func _on_select_ally_btn_button_up() -> void:
	if GSS.removing_ally_state: 
		self.queue_free()
		GSS.removing_ally_state = false
	else: %AllyUpgradeMenu.visible = true
