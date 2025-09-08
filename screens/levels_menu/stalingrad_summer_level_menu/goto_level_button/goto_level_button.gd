@tool
class_name GotoLevelButton extends TextureButton

@export var level: LevelData 

func set_state_visuals():
	if !level: return
	var ud_level: UDLevel = level.get_saved_ud_level()
	%NameLabel.text = level.level_name
	if ud_level.completed:
		%Icon.animation = "completed"
	if ud_level.locked:
		%Icon.animation = "locked"
	elif !ud_level.completed and !ud_level.locked:
		%Icon.animation = "unlocked"
		disabled = false
		modulate = Color.WHITE

func _on_pressed() -> void:
	SMS.change_scene(load(GC.SCREENS_UIDS.GAME), {"level": level})

func _on_focus_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_focus_exited() -> void:
	$AnimationPlayer.play("RESET")

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_mouse_exited() -> void:
	$AnimationPlayer.play("RESET")
