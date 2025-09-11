@tool
class_name GotoLevelButton extends TextureButton

var is_appearing : bool = true
@export var level: LevelData 

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	$Textures.modulate = "ffffff00"
	%NameLabel.visible_ratio = 0

func set_state_visuals():
	if !level: return
	var ud_level: UDLevel = level.get_saved_ud_level()
	%NameLabel.text = level.level_name
	if ud_level.completed:
		%Icon.animation = "completed"
		$Textures/IconLight.visible = false
		disabled = false
	if ud_level.locked:
		%Icon.animation = "locked"
		$Textures/IconLight.visible = false
		disabled = true
	elif !ud_level.completed and !ud_level.locked:
		%Icon.animation = "unlocked"
		$Textures/IconLight.visible = true
		disabled = false
		

	

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

func go_up():
	$AnimationPlayer.play("go_up")

func go_down():
	$AnimationPlayer.play("go_down")
