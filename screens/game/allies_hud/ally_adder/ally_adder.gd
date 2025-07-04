class_name AllyAdder extends VBoxContainer

var ally: Ally: set = _set_ally

func _ready() -> void:
	for child in %AlliesContainer.get_children():
		child.queue_free()

func _set_ally(new_value: Ally) -> void:
	ally = new_value
	%AllyTitle.text = ally.ally_name 
	%AddAllyBtn.disabled = true if ally.ud_ally.locked else false
	%AddAllyBtnLockedBanner.visible = true if ally.ud_ally.locked else false

func _on_add_ally_btn_pressed() -> void:
	var new_added_ally: AddedAlly = load("res://screens/game/allies_hud/ally_adder/added_ally/added_ally.tscn").instantiate()
	new_added_ally.ally = ally
	%AlliesContainer.add_child(new_added_ally)
