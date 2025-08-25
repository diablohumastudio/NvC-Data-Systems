@tool
class_name GotoLevelButton extends TextureButton

@export var level: LevelData :set = set_level

func set_level(new_value:LevelData) -> void:
	level = new_value
	if !level: return
	disabled = level.progress.locked

func _ready() -> void:
	if !level: return
	%NameLabel.text = level.level_name
	disabled = level.progress.locked

func _on_pressed() -> void:
	var games_screen: PackedScene = load("uid://0yp607cucppk")
	games_screen.level = level
	SMS.goto_scene(games_screen)


func _on_focus_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_focus_exited() -> void:
	$AnimationPlayer.play("RESET")

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("selected")

func _on_mouse_exited() -> void:
	$AnimationPlayer.play("RESET")
