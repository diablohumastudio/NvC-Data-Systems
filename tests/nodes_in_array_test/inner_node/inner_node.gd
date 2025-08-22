class_name InnerNode extends HBoxContainer

signal removed(node: InnerNode)

func _on_remove_button_pressed() -> void:
	self.queue_free()
	removed.emit(self)
