class_name DbugCanonHud extends VBoxContainer

var canons_alive: int = GC.TOTAL_NUMBER_OF_CANONS

func _on_canon_killed_btn_pressed() -> void:
	canons_alive -= 1
	%CanonsLeft.text = str(canons_alive) + " Canons Left"
