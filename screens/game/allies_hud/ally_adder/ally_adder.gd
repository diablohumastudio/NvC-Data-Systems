class_name AllyAdder extends VBoxContainer

var ally: Ally

func _ready() -> void:
	for child in %AlliesContainer.get_children(): child.queue_free()
	if ally: set_visuals()
	
func set_visuals():
	var base_level_id: String = ally.ud_ally.base_level.level_id
	var is_ally_unlocked: bool = ally.ud_ally.is_level_buyed(base_level_id)

	%AllyTitle.text = ally.ally_name 
	%AddAllyBtn.disabled = true if !is_ally_unlocked else false
	%AddAllyBtnLockedBanner.visible = true if !is_ally_unlocked else false

func _on_add_ally_btn_pressed() -> void:
	instatiate_sc_ally()

func instatiate_sc_ally() -> void:
	var sc_ally: ScAlly
	sc_ally = ally.scene.instantiate()
	sc_ally.ally = ally
	sc_ally.level = ally.ud_ally.base_level
	sc_ally.position = Vector2(200, 270)
	%AlliesContainer.add_child(sc_ally)
	var new_color_rect: ColorRect = ColorRect.new()
	new_color_rect.modulate = Color.TRANSPARENT
	new_color_rect.custom_minimum_size = Vector2(450, 450)
	%AlliesContainer.add_child(new_color_rect)
	%AlliesContainer.move_child(new_color_rect,0)
