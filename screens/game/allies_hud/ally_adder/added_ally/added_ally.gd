class_name AddedAlly extends HBoxContainer

var ally: Ally
var sc_ally: ScAlly 

func _ready() -> void:
	instatiate_sc_ally()

func instatiate_sc_ally() -> void:
	sc_ally = ally.scene.instantiate()
	sc_ally.ally = ally
	sc_ally.level = ally.ud_ally.base_level.level_id
	sc_ally.position = Vector2(250, 270)
	add_child(sc_ally)
	var new_color_rect: ColorRect = ColorRect.new()
	new_color_rect.modulate = Color.TRANSPARENT
	new_color_rect.custom_minimum_size = Vector2(450, 450)
	add_child(new_color_rect)
	move_child(new_color_rect,0)
