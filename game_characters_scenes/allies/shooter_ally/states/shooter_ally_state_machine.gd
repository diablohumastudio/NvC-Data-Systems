#region StateMachine External Class
class_name ShooterAllyStateMachine extends Node

var current_state: ShooterAllyState
var shooter_ally: ShooterAlly

var spawns_state: SpawnState
var idle_state: IdleState
var shooting_state: ShootingState
var blade_strike_state: BladeStrikeState
var dead_state: DeadState

func _ready():
	shooter_ally = get_parent() as ShooterAlly
	
	spawns_state = SpawnState.new(shooter_ally, self)
	idle_state = IdleState.new(shooter_ally, self)
	shooting_state = ShootingState.new(shooter_ally, self)
	blade_strike_state = BladeStrikeState.new(shooter_ally, self)
	dead_state = DeadState.new(shooter_ally, self)
	
	transition_to(spawns_state)

func transition_to(new_state: ShooterAllyState):
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

#func _process(delta):
	#if current_state:
		#current_state.update(delta)

func handle_damage():
	if current_state:
		current_state.handle_damage()

func handle_death():
	if current_state:
		current_state.handle_death()

#endregion


#region BaseState Inner Class
class ShooterAllyState extends RefCounted:
	var name: String
	var shooter_ally: ShooterAlly
	var state_machine: ShooterAllyStateMachine
	var state_animation_player: AnimationPlayer

	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		shooter_ally = ally
		state_machine = machine
		state_animation_player = shooter_ally.get_node("StateAnimationPlayer")

	func enter():
		pass

	func exit():
		pass

	func update(_delta: float):
		pass

	func handle_death():
		state_machine.transition_to(state_machine.dead_state)

	func handle_damage():
		if can_receive_damage():
			pass

	func can_receive_damage() -> bool:
		return true
#endregion

#region SpawnState Inner Class
class SpawnState extends ShooterAllyState:
	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		super(ally, machine)
		name = "SpawnState"

	func enter():
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		if state_animation_player.has_animation("spawn"):
			state_animation_player.play("spawn")
		else:
			state_machine.transition_to(state_machine.idle_state)
		super()

	func _on_state_animation_player_animation_finished(animation_name: String):
		if animation_name == "spawn":
			state_machine.transition_to(state_machine.idle_state)

	func update(_delta: float):
		pass

	func exit():
		state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
#endregion

#region IdleState Inner Class
class IdleState extends ShooterAllyState:
	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		super(ally, machine)
		name = "IdleState"

	func enter():
		super()
		state_animation_player.play("_idle")

	func update(_delta: float):
		pass

	func exit():
		pass
#endregion


#region ShootingState Inner Class
class ShootingState extends ShooterAllyState:
	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		super(ally, machine)
		name = "ShootingState"

	func enter():
		super()

	func update(_delta: float):
		pass

	func exit():
		pass
#endregion


#region BladeStrikeState Inner Class
class BladeStrikeState extends ShooterAllyState:
	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		super(ally, machine)
		name = "BladeStrikeState"

	func enter():
		super()

	func update(_delta: float):
		pass

	func exit():
		pass
#endregion


#region DeadState Inner Class
class DeadState extends ShooterAllyState:
	func _init(ally: ShooterAlly, machine: ShooterAllyStateMachine):
		super(ally, machine)
		name = "DeadState"

	func enter():
		super()

	func exit():
		pass

	func can_receive_damage() -> bool:
		return false
#endregion
