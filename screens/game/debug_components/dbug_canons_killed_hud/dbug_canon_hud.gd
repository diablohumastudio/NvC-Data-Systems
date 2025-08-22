class_name DbugCanonHud extends VBoxContainer

func _on_canon_killed_btn_pressed() -> void:
	GSS.canons_alive -= 1
	%CanonsLeft.text = str(GSS.canons_alive) + " Canons Left"
