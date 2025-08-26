@tool
class_name GotoLevelButton extends TextureButton

@export var level: LevelData :set = set_level

func set_level(new_value:LevelData) -> void:
	level = new_value
	if !level: return
	disabled = level.get_saved_ud_level().locked

func _ready() -> void:
	if !level: return
	%NameLabel.text = level.level_name
	disabled = level.get_saved_ud_level().locked

func _on_pressed() -> void:
	GSS.level = level
	GSS.reset_values()
	SMS.change_scene(load(GC.SCREENS_UIDS.GAME))

func _on_focus_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_focus_exited() -> void:
	$AnimationPlayer.play("RESET")

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_mouse_exited() -> void:
	$AnimationPlayer.play("RESET")
