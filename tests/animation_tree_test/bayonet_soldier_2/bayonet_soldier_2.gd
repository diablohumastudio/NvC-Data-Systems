class_name BayonetSolider2 extends GameCharacter

var long_obj_detected: bool = false
var short_obj_detected: bool = false
var dying: bool = false

#region For testing Only. Just creates an object where mouse click
const TEST_BODY_PKSC: PackedScene = preload("uid://didykuwbgj0mj")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		event = event as InputEventMouse
		var new_test_body: TestBody = TEST_BODY_PKSC.instantiate()
		add_child(new_test_body)
		new_test_body.global_position = event.position
#endregion

func _check_for_objects():
	short_obj_detected = _has_short_distance_objects()
	long_obj_detected = _has_long_distance_objects()

func _has_long_distance_objects() -> bool:
	return %LongDetenctionArea2D.has_overlapping_bodies()

func _has_short_distance_objects() -> bool:
	return %ShortDetenctionArea2D.has_overlapping_bodies()

func _on_die_button_pressed() -> void:
	dying = true
