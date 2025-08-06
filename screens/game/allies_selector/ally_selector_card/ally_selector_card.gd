class_name AllySelectorCard extends VBoxContainer

var ally: Ally

func start_time_blocking():
	if !%AnimationPlayer.animation_finished.is_connected(_on_animation_player_animation_finished):
		(%AnimationPlayer as AnimationPlayer).animation_finished.connect(_on_animation_player_animation_finished)
	%AllySelCardBtn.button_pressed = false
	%AnimationPlayer.play("time_block_unblocking")
	%AllySelCardBtn.disabled = true

func _on_animation_player_animation_finished(animation_name: String):
	if animation_name == "time_block_unblocking":
		%AllySelCardBtn.disabled = false

func _ready() -> void:
	if !ally: return
	%AllyName.text = ally.ally_name
	%AllySelCardBtn.texture_normal = ally.base_level.ally_selector_thumbnail
	%AllySelCardBtn.set_meta("ally", ally)

func _on_ally_sel_card_btn_toggled(toggled_on: bool) -> void:
	if toggled_on: modulate = Color.GREEN
	else: modulate = Color.WHITE
