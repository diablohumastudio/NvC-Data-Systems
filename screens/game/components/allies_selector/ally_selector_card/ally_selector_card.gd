class_name AllySelectorCard extends VBoxContainer

@export var ally: AllyData

func _ready() -> void:
	if !ally: 
		push_error("AllySelectorCard MUST have setted an ally before enter tree")
		return
	%AllyName.text = ally.ally_name
	%AllySelCardBtn.texture_normal = ally.ally_selector_thumbnail
	GSS.ally_just_placed.connect(_on_GSS__ally_just_placed)

#region TimeBlocking for when ally has just been placed
func _on_GSS__ally_just_placed(_ally:AllyData):
	if ally == _ally: _start_time_blocking()
	
func _start_time_blocking():
	if !%AnimationPlayer.animation_finished.is_connected(_on_animation_player_animation_finished):
		(%AnimationPlayer as AnimationPlayer).animation_finished.connect(_on_animation_player_animation_finished)
	%AllySelCardBtn.button_pressed = false
	%AnimationPlayer.play("time_block_unblocking")
	%AllySelCardBtn.disabled = true

func _on_animation_player_animation_finished(animation_name: String):
	if animation_name == "time_block_unblocking":
		%AllySelCardBtn.disabled = false
#endregion

#region SelectorFuncion including seting the state of Game
# pressed signal callback always run after all button_group pertinent buttons call toggled signal callback
func _on_ally_sel_card_btn_pressed() -> void: 
	if %AllySelCardBtn.button_pressed == true: GSS.ally_to_place = ally
	else: GSS.ally_to_place = null

func _on_ally_sel_card_btn_toggled(toggled_on: bool) -> void:
	if toggled_on: modulate = Color.GREEN
	else: modulate = Color.WHITE
#endregion
