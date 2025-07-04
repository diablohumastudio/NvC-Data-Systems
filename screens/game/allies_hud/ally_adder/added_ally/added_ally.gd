class_name AddedAlly extends HBoxContainer

var ally: Ally: set = _set_ally
var level: int = 1

func _set_ally(new_value:Ally):
	ally = new_value
	_update_label()
	%UpgradeBtn.disabled = true if level <= ally.ud_ally.level else false

func _on_upgrade_btn_pressed() -> void:
	level += 1

func _update_label() -> void:
	%Label.text = ally.ally_name + " in level: " + str(level)
