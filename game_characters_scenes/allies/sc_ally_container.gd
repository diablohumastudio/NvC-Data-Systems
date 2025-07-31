class_name ScAllyContainer extends Node2D

var level: AllyLevel: set = _set_level
var ally: Ally
var hp: int

var scene_ally: ScAlly

func _set_level(new_value: AllyLevel):
	level = new_value
	if is_inside_tree():
		set_text_and_scene()

func _ready() -> void:
	%AllyUpgradePopUp.ally = ally
	%AllyUpgradePopUp.level_changed.connect(on_ally_upgrade_menu_level_changed)
	set_text_and_scene()

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func set_text_and_scene():
	%AllyNameAndLevelLabel.text = "Type: " + ally.ally_name + "\n Level " + str(level.level_id)
	scene_ally = level.scene.instantiate()
	get_node("ScAlly").free()
	add_child(scene_ally)
	call_deferred("_change_scally_name")

func _change_scally_name():
	scene_ally.name = "ScAlly"

func _on_show_upgrade_popup_btn_pressed() -> void:
	%AllyUpgradePopUp.visible = true
