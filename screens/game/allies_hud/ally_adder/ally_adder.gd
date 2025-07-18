class_name AllyAdder extends VBoxContainer

var ally: Ally

func _ready() -> void:
	for child in %AlliesContainer.get_children(): child.queue_free()
	if ally: set_visuals()
	
func set_visuals():
	var base_level_id: String = ally.ud_ally.base_level.level_id
	var is_ally_unlocked: bool = ally.ud_ally.is_level_buyed(base_level_id)
	print(base_level_id, is_ally_unlocked)
	%AllyTitle.text = ally.ally_name 
	%AddAllyBtn.disabled = true if !is_ally_unlocked else false
	%AddAllyBtnLockedBanner.visible = true if !is_ally_unlocked else false

func _on_add_ally_btn_pressed() -> void:
	var new_added_ally: AddedAlly = load("res://screens/game/allies_hud/ally_adder/added_ally/added_ally.tscn").instantiate()
	new_added_ally.ally = ally
	%AlliesContainer.add_child(new_added_ally)
