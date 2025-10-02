class_name BayonetSoldier extends CharacterBody2D

## This character has a method call in this animation of AnimationPlayer: 
## "death" (Node.queue_free())

const MAX_WAIT_CYCLES : int = 2

@export var initial_hp : float
var hp : float
var wait_cycles_counter : int = 0
var are_wait_cycles_finished : bool
var long_opponent_detected : bool
var short_opponent_detected : bool
var needs_reload : bool

## AllyLevel Variables
@export var shooting_power : float
@export var shooting_speed : float
@export var shooting_range : int
var hp_increment : float

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
	%AnimationTree.animation_finished.connect(_on_anim_tree_animation_finished)
	#%AnimationPlayer.speed_scale = 5.0 # Initial Level Setting

func upgrade_ally_level(new_level:TestAllyLevelUpgrade) -> void:
	shooting_power += new_level.shooting_power_increment
	shooting_speed += new_level.shooting_speed_increment
	shooting_range += new_level.shooting_range_increment
	if new_level.hp_increment != 0.0:
		hp += new_level.hp_increment * (hp/initial_hp)

func receive_damage(damage_points:float) -> void:
	hp -= damage_points
	%AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func _check_dying_conditions() -> void:
	if hp <= 0:
		_die()

func _on_anim_tree_animation_finished(animation_name:String) -> void:
	if animation_name == "receive_damage":
		_check_dying_conditions()

## This function is called from animation: "check_transitions"
func _check_transitions() -> void:
	long_opponent_detected = %LongOpponentsArea.has_overlapping_bodies()
	short_opponent_detected = %ShortOpponentsArea.has_overlapping_bodies()
	are_wait_cycles_finished = wait_cycles_counter == MAX_WAIT_CYCLES
	needs_reload = false

	if !(short_opponent_detected or long_opponent_detected):
		#%AnimationPlayer.speed_scale = 1.00 # Initial Level Setting
		return # No enemies detected so no need to use idle_cycle_counter
	
	if long_opponent_detected and !short_opponent_detected:
		%AnimationTree.set("parameters/TimeScale/scale", 5.0)
	_update_wait_cycle_counter()

func _update_wait_cycle_counter() -> void:
	if wait_cycles_counter == MAX_WAIT_CYCLES:
		wait_cycles_counter = 0 # If idle cycles finished, reset idle_cycles_counter and return
		return
	wait_cycles_counter += 1

## This function is called from animation: "shoot"
func _on_shoot_animation_finishing() -> void:
	needs_reload = true

func _on_test_dying_btn_pressed() -> void:
	_die()

func _die() -> void:
	state_machine_playback.travel("death")

func _on_test_damage_button_pressed() -> void:
	receive_damage(2.0)
	print("hp: ", hp)

func _on_test_level_upgrade_btn_pressed() -> void:
	var new_level : TestAllyLevelUpgrade = TestAllyLevelUpgrade.new()
	new_level.shooting_power_increment = 0.0
	new_level.shooting_speed_increment = 0.5
	new_level.shooting_range_increment = 0
	new_level.hp_increment = 2.0
	
	upgrade_ally_level(new_level)
