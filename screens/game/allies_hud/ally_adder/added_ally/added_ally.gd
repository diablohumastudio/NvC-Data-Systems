class_name AddedAlly extends HBoxContainer

var ally: Ally
var new_sc_ally: ScAlly 

func _update_upgrade_button():
	%UpgradeBtn.disabled = ally.ud_ally.locked or new_sc_ally.level >= ally.ud_ally.level

func _ready() -> void:
	instatiate_sc_ally()
	_update_upgrade_button()

func _on_upgrade_btn_pressed() -> void:
	print("presses")
	if ally && !ally.ud_ally.locked && new_sc_ally.level < ally.ud_ally.level:
		new_sc_ally.level += 1
		_update_upgrade_button()

func instatiate_sc_ally() -> void:
	new_sc_ally = ally.scene.instantiate()
	new_sc_ally.ally = ally
	new_sc_ally.level = 1
	new_sc_ally.position = Vector2(150, 270)
	add_child(new_sc_ally)
	var new_color_rect: ColorRect = ColorRect.new()
	new_color_rect.modulate = Color.TRANSPARENT
	new_color_rect.custom_minimum_size = Vector2(300, 450)
	add_child(new_color_rect)
	move_child(new_color_rect,0)
