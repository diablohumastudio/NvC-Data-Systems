class_name DebugComponents extends Control

func _on_show_components_btn_toggled(toggled_on: bool) -> void:
	%ComponentsContainer.visible = toggled_on
