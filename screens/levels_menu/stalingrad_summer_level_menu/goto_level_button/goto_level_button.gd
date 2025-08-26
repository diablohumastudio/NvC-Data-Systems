@tool
class_name GotoLevelButton extends TextureButton

@export var level: LevelData :set = set_level

func set_level(new_value:LevelData) -> void:
	level = new_value
	if Engine.is_editor_hint(): 
		set_state_visuals()

func _ready() -> void:
	pass
	#set_state_visuals()

func set_state_visuals():
	if !level: return
	var ud_level: UDLevel = level.get_saved_ud_level()
	%NameLabel.text = level.level_name
	print(ud_level.completed)
	if ud_level.completed:
		print("completed")
		modulate = Color.AQUA
	if ud_level.locked:
		disabled = true
		modulate = Color.CADET_BLUE
	elif !ud_level.completed and !ud_level.locked:
		disabled = false
		modulate = Color.WHITE

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
