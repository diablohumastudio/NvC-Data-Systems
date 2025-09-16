class_name IronChest extends CharacterBody2D

var dying: bool = false
var reciving_damage: bool = false

func _ready() -> void:
	pass

func _on_die_btn_pressed() -> void:
	die()

func die():
	dying = true

func _on_recieve_damage_btn_pressed() -> void:
	recieve_damage()

func recieve_damage():
	%AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func _spawn_coin():
	pass
