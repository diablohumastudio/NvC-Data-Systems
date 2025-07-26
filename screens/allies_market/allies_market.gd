class_name AlliesMarket extends Control

var allies: Array[Ally] = DataFilesLoader.get_allies_from_res_files()

func _ready() -> void:
	for child in %MAPContainer.get_children():
		child.queue_free()
	for ally in allies:
		var new_ally_presenter: MarketAllyPresenter = load("res://screens/allies_market/market_ally_presenter/market_ally_presenter.tscn").instantiate()
		new_ally_presenter.ally = ally
		new_ally_presenter.ally_details_requested.connect(_on_ally_details_requested)
		%MAPContainer.add_child(new_ally_presenter)

func _on_ally_details_requested(ally: Ally) -> void:
	%AllyDetailsPopup.ally = ally
	%AllyDetailsPopup.show()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)

func _on_present_unlocked_allies_button_pressed() -> void:
	var text_to_present: String = ""
	for ally in allies:
		if !ally.get_saved_ud_ally(): continue
		for ud_ally_level in ally.get_saved_ud_ally().ud_levels:
			text_to_present = text_to_present + str(ud_ally_level.id) + (" is_unloked" if ud_ally_level.unlocked else " is locked") + "\n"
	%PresentUnlockedAlliesLabel.text = text_to_present
