class_name AllyScene extends GameCharaterScene

signal pressed

var terrain_grid_cell_width: int

func _ready() -> void:
	%SelectAllyBtn.pressed.connect(_on_select_btn_pressed)

func _on_select_btn_pressed():
	pressed.emit()
