class_name ShooterEnemy extends EnemyScene

#const BULLET_SCENE_UID : String = "uid://v2dsu1x0lbhw"

# Inherits hp, current_hp, accuracy_points, DAMAGE_TYPES from GameCharacter via Enemy
# Note: using 'hp' instead of 'initial_hp' for consistency with base class

@onready var state_machine : ShooterEnemyStateMachine = %ShooterEnemyStateMachine

var short_range_opponents : Array[AllyScene]
var long_range_opponents : Array[AllyScene]
var long_range_accuracy_points : float 
var short_range_accuracy_points : float
var long_range_damage_type : GameCharacter.DAMAGE_TYPES
var short_range_damage_type : GameCharacter.DAMAGE_TYPES

func _process(_delta: float) -> void:
	if state_machine.is_walking:
		_move_left()

func _ready() -> void:
	super._ready()  # Call parent _ready() which sets current_hp = hp
	(%PhysicalContactArea as Area2D).body_entered.connect(_on_physical_contact_area_body_entered)
	(%PhysicalContactArea as Area2D).body_exited.connect(_on_physical_contact_area_body_exited)
	(%ShootingRangeArea as Area2D).body_entered.connect(_on_shooting_range_area_body_entered)
	(%ShootingRangeArea as Area2D).body_exited.connect(_on_shooting_range_area_body_exited)

func _move_left() -> void:
	var movement_step : float = 0.8
	position.x -= movement_step

func receive_damage(damage_points: float, _damage_type: GameCharacter.DAMAGE_TYPES):
	super(damage_points, _damage_type)  # Calls Enemy.receive_damage which prints HP
	state_machine.handle_damage(_damage_type)
	check_dying_conditions()
	#if _damage_type == GameCharacter.DAMAGE_TYPES.SHORT_NORMAL:
		#print("enemy hp after ally's stabbing attack: ", current_hp)

func check_dying_conditions() -> void:
	super()  # Uses base class logic

func create_and_shoot_bullet() -> void:
	pass
	## Disabled until implementing new bullet
	#var bullet : Bullet = load(BULLET_SCENE_UID).instantiate() as Bullet
	#var total_rows_number : int = 5
	#var required_collision_mask : int
	#var required_z_index : int
	#%BulletStartingPosition.add_child(bullet)
	#
	#for ii in total_rows_number:
		#if get_collision_mask_value(ii+1) == true:
			#required_collision_mask = ii + 1
		#if get_z_index() == ii:
			#required_z_index = ii
	#
	#bullet.set_properties("left", required_collision_mask, long_range_accuracy_points, required_z_index, long_range_damage_type)
	#bullet.shoot_bullet()

func perform_stabbing_damage() -> void:
	# ENEMY STABBING DAMAGE SYSTEM IMPLEMENTATION
	# Called immediately when entering StabbingState for responsive combat
	# Damage calculation: base 1.0 multiplied by accuracy points for scaling
	var total_short_range_opponents : int = short_range_opponents.size()
	var damage_to_inflict : float = 1.0 * short_range_accuracy_points
	
	# Target selection: Uses first ally in short_range_opponents array
	# Array populated by PhysicalContactArea body_entered/exited signals
	if total_short_range_opponents != 0:
		for ii in total_short_range_opponents:
			var opponent : AllyScene = short_range_opponents[ii]
			if !opponent.is_dying:
				opponent.receive_damage(damage_to_inflict, short_range_damage_type)
	else:
		# WARNING: If this occurs frequently, indicates PhysicalContactArea signal issues
		# The stabbing state can be entered via array detection,
		# but damage requires signal-populated array. Signal reliability is critical.
		return

func die():
	super()
	state_machine.handle_death()

func _on_physical_contact_area_body_entered(body: Node2D) -> void:
	# OPPONENT TRACKING SYSTEM - CRITICAL for stabbing damage targeting
	# This signal populates the short_range_opponents array used by perform_stabbing_damage()
	# If this signal fails to fire, stabbing state will enter but no damage will occur
	if body != null and body is AllyScene:
		short_range_opponents.append(body)
		# Trigger state machine detection after array population
		if state_machine.current_state and state_machine.current_state.has_method("check_for_enemies"):
			state_machine.current_state.check_for_enemies()
	else:
		return

func _on_physical_contact_area_body_exited(body: Node2D) -> void:
	# OPPONENT TRACKING CLEANUP - Removes allies that leave stabbing range
	# Ensures short_range_opponents array accuracy for damage targeting
	if body != null and body is AllyScene:
		if short_range_opponents.has(body):
			short_range_opponents.erase(body)
			# Trigger state machine detection after array cleanup
			if state_machine.current_state and state_machine.current_state.has_method("check_for_enemies"):
				state_machine.current_state.check_for_enemies()
	else:
		return

func _on_shooting_range_area_body_entered(body: Node2D) -> void:
	# LONG RANGE OPPONENT TRACKING SYSTEM - CRITICAL for shooting state transitions
	# This signal populates the long_range_opponents array used for state decisions
	if body != null and body is AllyScene:
		long_range_opponents.append(body)
		# Trigger state machine detection after array population
		if state_machine.current_state and state_machine.current_state.has_method("check_for_enemies"):
			state_machine.current_state.check_for_enemies()
	else:
		return

func _on_shooting_range_area_body_exited(body: Node2D) -> void:
	# LONG RANGE OPPONENT TRACKING CLEANUP - Removes allies that leave shooting range  
	# Ensures long_range_opponents array accuracy for state transitions
	if body != null and body is AllyScene:
		if long_range_opponents.has(body):
			long_range_opponents.erase(body)
			# Trigger state machine detection after array cleanup
			if state_machine.current_state and state_machine.current_state.has_method("check_for_enemies"):
				state_machine.current_state.check_for_enemies()
	else:
		return
