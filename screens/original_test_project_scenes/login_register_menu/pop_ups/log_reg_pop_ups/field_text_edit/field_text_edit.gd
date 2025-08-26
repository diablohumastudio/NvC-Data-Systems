class_name FieldTextEdit extends TextEdit

func _ready() -> void:
	text_changed.connect(_on_text_changed)

func _on_text_changed() -> void:
	check_is_empty()

func check_is_empty():
	if text == "":
		warn_validation("Must not be empty")

func warn_validation(warning_text: String):
		var previous_placeholder_text = placeholder_text
		modulate = Color.RED
		placeholder_text = warning_text
		await get_tree().create_timer(1.5).timeout
		modulate = Color.WHITE
		placeholder_text = previous_placeholder_text
