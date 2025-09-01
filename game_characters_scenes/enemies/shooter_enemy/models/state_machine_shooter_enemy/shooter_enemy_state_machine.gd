class_name ShooterEnemyStateMachine extends Node

var current_state
var shooter_enemy : ShooterEnemy
var is_walking : bool

var walking_state : WalkingState
var shooting_state : ShootingState
var stabbing_state : StabbingState
var dying_state : DyingState
"uid://v2dsu1x0lbhw"
func _ready() -> void:
	shooter_enemy = get_parent() as ShooterEnemy
	walking_state = WalkingState.new(shooter_enemy, self)
	shooting_state = ShootingState.new(shooter_enemy, self)
	stabbing_state = StabbingState.new(shooter_enemy, self)
	dying_state = DyingState.new(shooter_enemy, self)
	
	walking_state.started_walking.connect(_on_enemy_state_started_walking)
	walking_state.stopped_walking.connect(_on_enemy_state_stopped_walking)
	
	transition_to(walking_state)

func _on_enemy_state_started_walking() -> void:
	is_walking = true

func _on_enemy_state_stopped_walking() -> void:
	is_walking = false

func transition_to(new_state:ShooterEnemyState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func handle_damage(damage_type: GameCharacter.DAMAGE_TYPES) -> void:
	if current_state:
		current_state.handle_damage(damage_type)

func handle_death() -> void:
	if current_state:
		current_state.handle_death()
	
class ShooterEnemyState extends RefCounted:
	signal started_walking()
	signal stopped_walking()
	
	enum OPPONENT_DISTANCE { NONE, SHORT, ONLY_LONG}
	var current_opponent_distance : OPPONENT_DISTANCE
	
	var shooter_enemy : ShooterEnemy
	var state_machine : ShooterEnemyStateMachine
	var state_animation_player : AnimationPlayer
	var receive_damage_player : AnimationPlayer
	var shooting_range_area : Area2D
	var physical_contact_area : Area2D
	var walking_animation : Animation
	var bullet_starting_position : Marker2D
	
	func _init(enemy:ShooterEnemy, machine:ShooterEnemyStateMachine) -> void:
		shooter_enemy = enemy
		state_machine = machine
		state_animation_player = shooter_enemy.get_node("%StateAnimationPlayer")
		receive_damage_player = shooter_enemy.get_node("%ReceiveDamage")
		shooting_range_area = shooter_enemy.get_node("%ShootingRangeArea")
		physical_contact_area = shooter_enemy.get_node("%PhysicalContactArea")
		walking_animation = state_animation_player.get_animation("_walking")
		bullet_starting_position = shooter_enemy.get_node("%BulletStartingPosition")
	
	func enter() -> void:
		receive_damage_player.animation_finished.connect(_on_receive_damage_animation_player_animation_finished)
		
	func handle_damage(damage_type:GameCharacter.DAMAGE_TYPES) -> void:
		if damage_type == GameCharacter.DAMAGE_TYPES.LONG_NORMAL:
			receive_damage_player.play("_receive_damage_general")
			
		if damage_type == GameCharacter.DAMAGE_TYPES.SHORT_NORMAL:
			receive_damage_player.play("_receive_damage_general")

		if damage_type == GameCharacter.DAMAGE_TYPES.SHORT_EXPLOSION:
			receive_damage_player.play("_receive_damage_from_explosion")

	func handle_death() -> void:
		state_machine.transition_to(state_machine.dying_state)

	func _on_receive_damage_animation_player_animation_finished(animation_name:String) -> void:
		if animation_name == "_receive_damage_general":
			shooter_enemy.check_dying_conditions()
	
	func exit() -> void:
		if receive_damage_player.animation_finished.is_connected(_on_receive_damage_animation_player_animation_finished):
			receive_damage_player.animation_finished.disconnect(_on_receive_damage_animation_player_animation_finished)

class WalkingState extends ShooterEnemyState:
	var completed_walking_cycle : bool = false
	
	func enter() -> void:
		_setup_signals()
		check_for_enemies()
		state_animation_player.play("_walking")
		started_walking.emit()

	func _setup_signals() -> void:
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		# Don't connect area signals here - let ShooterEnemy handle them first
		# shooting_range_area.body_entered.connect(_on_shooting_range_area_body_entered)
		# physical_contact_area.body_entered.connect(_on_physical_contact_area_body_entred)

	func check_for_enemies() -> void:
		# ARRAY-BASED DETECTION - Uses signal-populated arrays for accurate enemy tracking
		# This prevents false positives from dead allies or enemies walking in front
		var total_short_range_opponents : int = shooter_enemy.short_range_opponents.size()
		var total_long_range_opponents : int = shooter_enemy.long_range_opponents.size()
		var opponent_at_short_range : bool = total_short_range_opponents > 0
		var opponent_at_long_range : bool = total_long_range_opponents > 0
		
		# If enemies detected, stop the animation loop so it will finish and fire animation_finished
		if opponent_at_short_range or opponent_at_long_range:
			if walking_animation.loop_mode == Animation.LOOP_LINEAR:
					walking_animation.loop_mode = Animation.LOOP_NONE
		elif current_opponent_distance == OPPONENT_DISTANCE.NONE:
			# No enemies - ensure animation keeps looping
			if walking_animation.loop_mode != Animation.LOOP_LINEAR:
					walking_animation.loop_mode = Animation.LOOP_LINEAR
				
		if opponent_at_short_range:
			for ii in total_short_range_opponents:
				var opponent : AllyScene = shooter_enemy.short_range_opponents[ii]
				if opponent.is_dying:
					total_short_range_opponents -= 1
			
			if total_short_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.SHORT
			else:
				opponent_at_short_range = false
				
		elif opponent_at_long_range and !opponent_at_short_range:
			for ii in total_long_range_opponents:
				var opponent : AllyScene = shooter_enemy.long_range_opponents[ii]
				if opponent.is_dying:
					total_long_range_opponents -= 1
			
			if total_long_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.ONLY_LONG
			else:
				opponent_at_long_range = false

		elif !opponent_at_long_range and !opponent_at_short_range:
			current_opponent_distance = OPPONENT_DISTANCE.NONE
		
				
	func _on_shooting_range_area_body_entered(_body:Node2D) -> void:
		check_for_enemies()

	func _on_physical_contact_area_body_entred(_body:Node2D) -> void:
		check_for_enemies()

	func _on_state_animation_player_animation_finished(animation_name:String) -> void:
		if animation_name == "_walking":
			check_for_enemies()
			if current_opponent_distance != OPPONENT_DISTANCE.NONE:
				if completed_walking_cycle:
					state_animation_player.play("_idle")
					stopped_walking.emit()
					completed_walking_cycle = false
				else:
					completed_walking_cycle = true
					state_animation_player.play("_walking")
			else:
				# No enemies - continue walking normally
				state_animation_player.play("_walking")
			
		elif animation_name == "_idle":
			if current_opponent_distance == OPPONENT_DISTANCE.SHORT:
				state_machine.transition_to(state_machine.stabbing_state)
				
			elif current_opponent_distance == OPPONENT_DISTANCE.ONLY_LONG:
				state_machine.transition_to(state_machine.shooting_state)

	func _disconnect_signals() -> void:
		if state_animation_player.animation_finished.is_connected(_on_state_animation_player_animation_finished):
			state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
		if shooting_range_area.body_entered.is_connected(_on_shooting_range_area_body_entered):
			shooting_range_area.body_entered.disconnect(_on_shooting_range_area_body_entered)
		if physical_contact_area.body_entered.is_connected(_on_physical_contact_area_body_entred):
			physical_contact_area.body_entered.disconnect(_on_physical_contact_area_body_entred)

	func exit() -> void:
		_disconnect_signals()
		current_opponent_distance = OPPONENT_DISTANCE.NONE
		walking_animation.loop_mode = Animation.LOOP_LINEAR

class ShootingState extends ShooterEnemyState:
	
	func enter() -> void:
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		check_for_enemies()
		if current_opponent_distance == OPPONENT_DISTANCE.SHORT:
			state_machine.transition_to(state_machine.stabbing_state)
		elif current_opponent_distance == OPPONENT_DISTANCE.ONLY_LONG:
			state_animation_player.play("_shoot")
			shooter_enemy.create_and_shoot_bullet()
		elif current_opponent_distance == OPPONENT_DISTANCE.NONE:
			state_machine.transition_to(state_machine.walking_state)

	func check_for_enemies() -> void:
		# ARRAY-BASED DETECTION - Uses signal-populated arrays for accurate enemy tracking
		# This prevents false positives from dead allies or enemies walking in front
		var total_short_range_opponents : int = shooter_enemy.short_range_opponents.size()
		var total_long_range_opponents : int = shooter_enemy.long_range_opponents.size()
		var opponent_at_short_range : bool = total_short_range_opponents > 0
		var opponent_at_long_range : bool = total_long_range_opponents > 0
				
		if opponent_at_short_range:
			for ii in total_short_range_opponents:
				var opponent : AllyScene = shooter_enemy.short_range_opponents[ii]
				if opponent.is_dying:
					total_short_range_opponents -= 1
			
			if total_short_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.SHORT
			else:
				opponent_at_short_range = false
				
		elif opponent_at_long_range and !opponent_at_short_range:
			for ii in total_long_range_opponents:
				var opponent : AllyScene = shooter_enemy.long_range_opponents[ii]
				if opponent.is_dying:
					total_long_range_opponents -= 1
			
			if total_long_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.ONLY_LONG
			else:
				opponent_at_long_range = false

		elif !opponent_at_long_range and !opponent_at_short_range:
			current_opponent_distance = OPPONENT_DISTANCE.NONE
			walking_animation.loop_mode = Animation.LOOP_LINEAR

	func _on_state_animation_player_animation_finished(animation_name:String) -> void:
		if animation_name == "_shoot":
			state_animation_player.play("_idle")
		
		elif animation_name == "_idle":
			check_for_enemies()
			if current_opponent_distance == OPPONENT_DISTANCE.SHORT:
				state_machine.transition_to(state_machine.stabbing_state)
			else:
				state_machine.transition_to(state_machine.walking_state)

	func exit() -> void:
		if state_animation_player.animation_finished.is_connected(_on_state_animation_player_animation_finished):
			state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
		current_opponent_distance = OPPONENT_DISTANCE.NONE

class StabbingState extends ShooterEnemyState:
	func enter() -> void:
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		check_for_enemies()
		if current_opponent_distance == OPPONENT_DISTANCE.SHORT:
			state_animation_player.play("_stab")
		elif current_opponent_distance == OPPONENT_DISTANCE.ONLY_LONG:
			state_machine.transition_to(state_machine.shooting_state)
		elif current_opponent_distance == OPPONENT_DISTANCE.NONE:
			state_machine.transition_to(state_machine.walking_state)

	func check_for_enemies() -> void:
		# ARRAY-BASED DETECTION - Uses signal-populated arrays for accurate enemy tracking
		# This prevents false positives from dead allies or enemies walking in front
		var total_short_range_opponents : int = shooter_enemy.short_range_opponents.size()
		var total_long_range_opponents : int = shooter_enemy.long_range_opponents.size()
		var opponent_at_short_range : bool = total_short_range_opponents > 0
		var opponent_at_long_range : bool = total_long_range_opponents > 0
				
		if opponent_at_short_range:
			for ii in total_short_range_opponents:
				var opponent : AllyScene = shooter_enemy.short_range_opponents[ii]
				if opponent.is_dying:
					total_short_range_opponents -= 1
			
			if total_short_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.SHORT
			else:
				opponent_at_short_range = false
				
		elif opponent_at_long_range and !opponent_at_short_range:
			for ii in total_long_range_opponents:
				var opponent : AllyScene = shooter_enemy.long_range_opponents[ii]
				if opponent.is_dying:
					total_long_range_opponents -= 1
			
			if total_long_range_opponents > 0:
				current_opponent_distance = OPPONENT_DISTANCE.ONLY_LONG
			else:
				opponent_at_long_range = false

		elif !opponent_at_long_range and !opponent_at_short_range:
			current_opponent_distance = OPPONENT_DISTANCE.NONE
			walking_animation.loop_mode = Animation.LOOP_LINEAR

	func _on_state_animation_player_animation_finished(animation_name:String) -> void:
		if animation_name == "_stab":
			shooter_enemy.perform_stabbing_damage()
			state_animation_player.play("_idle")

		elif animation_name == "_idle":
			check_for_enemies()
			if current_opponent_distance == OPPONENT_DISTANCE.SHORT:
				state_machine.transition_to(state_machine.stabbing_state)
			elif  current_opponent_distance == OPPONENT_DISTANCE.ONLY_LONG:
				state_machine.transition_to(state_machine.shooting_state)
			else:
				state_machine.transition_to(state_machine.walking_state)

	func exit() -> void:
		if state_animation_player.animation_finished.is_connected(_on_state_animation_player_animation_finished):
			state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
		current_opponent_distance = OPPONENT_DISTANCE.NONE

class DyingState extends ShooterEnemyState:
	func enter() -> void:
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		state_animation_player.play("_death")

	func _on_state_animation_player_animation_finished(animation_name:String) -> void:
		if animation_name == "_death":
			shooter_enemy.queue_free()

	## handle_damage and handle_death functions are intentionally empty to override BaseState's inherited implementantions
	func handle_damage(_damage_type:GameCharacter.DAMAGE_TYPES) -> void:
		pass

	func handle_death() -> void:
		pass

	func exit() -> void:
		if state_animation_player.animation_finished.is_connected(_on_state_animation_player_animation_finished):
			state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
