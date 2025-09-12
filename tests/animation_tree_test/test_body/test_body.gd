class_name TestBody extends CharacterBody2D

func _on_delete_button_pressed() -> void:
	self.queue_free()
