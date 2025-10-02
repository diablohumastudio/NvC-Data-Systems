class_name ShieldSoldier extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_WAIT_CYCLES : int = 2

@export var initial_hp : float
var hp : float
var wait_cycles_counter : int = 0
var are_wait_cycles_finished : bool
var short_opponent_detected : bool = false
var long_opponent_detected : bool = false
var dying : bool
var receiving_damage : bool

@onready var shield : CharacterBody2D = %Shield
@onready var state_machine_playback : AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/StateMachine/playback")

#region For testing Only. Just creates an object where mouse click
const TEST_BODY_PKSC: PackedScene = preload("uid://didykuwbgj0mj")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		event = event as InputEventMouse
		var new_test_body: TestBody = TEST_BODY_PKSC.instantiate()
		new_test_body.set_collision_layer_value(2, true)
		add_child(new_test_body)
		new_test_body.global_position = event.position
#endregion

func _ready() -> void:
	hp = initial_hp

func receive_damage(damage_points:float) -> void:
	if dying:
		return
	if receiving_damage:
		hp -= damage_points
		return
	receiving_damage = true
	hp -= damage_points
	%AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

## This function is called from animation: "check_transitions"
func _check_transitions() -> void:
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()
	are_wait_cycles_finished = wait_cycles_counter == MAX_WAIT_CYCLES

	if !(short_opponent_detected or long_opponent_detected):
		return # No enemies detected so no need to use idle_cycle_counter
	_update_wait_cycle_counter()

func _update_wait_cycle_counter() -> void:
	if wait_cycles_counter == MAX_WAIT_CYCLES:
		wait_cycles_counter = 0 # If idle cycles finished, reset idle_cycles_counter and return
		return
	wait_cycles_counter += 1

func _check_dying_conditions() -> void:
	if hp <= 0:
		_die()

func _on_receive_damage_anim_finished() -> void:
	receiving_damage = false
	_check_dying_conditions()

func _on_test_dying_btn_pressed() -> void:
	_die()

func _on_test_damage_button_pressed() -> void:
	if shield:
		shield.receive_damage(2.0)
		print("shield's hp: ", shield.hp)
	else:
		receive_damage(2)
		print("hp: ", hp)

func _die() -> void:
	dying = true
	state_machine_playback.travel("death")
