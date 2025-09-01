class_name Cell extends Button

@export var column: int
@export var row: int

func is_ocupied() -> bool:
	return !get_child_count() == 0
