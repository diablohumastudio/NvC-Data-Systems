#region StateMachine External Class
class_name ResourceProviderStateMachine extends Node

var current_state: ResourceProviderState
var resource_provider: ResourceProvider

var spawn_state: SpawnState
var idle_state: IdleState
var giving_coin_state: GivingCoinState
var dead_state: DeadState

func _ready():
	resource_provider = get_parent() as ResourceProvider
	
	spawn_state = SpawnState.new(resource_provider, self)
	idle_state = IdleState.new(resource_provider, self)
	giving_coin_state = GivingCoinState.new(resource_provider, self)
	dead_state = DeadState.new(resource_provider, self)
	
	transition_to(spawn_state)

func transition_to(new_state: ResourceProviderState):
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
class ResourceProviderState extends RefCounted:
	var name: String
	var resource_provider: ResourceProvider
	var state_machine: ResourceProviderStateMachine
	var state_animation_player: AnimationPlayer 

	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		resource_provider = provider
		state_machine = machine
		state_animation_player = resource_provider.get_node("%StateAnimationPlayer")

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
			if resource_provider.has_node("%ReceiveDamageAnimationPlayer"):
				resource_provider.get_node("%ReceiveDamageAnimationPlayer").play("_receive_damage_general")

	func can_receive_damage() -> bool:
		return true






class IdleState extends ResourceProviderState:
	var coin_drop_timer: Timer
	
	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "IdleState"
		coin_drop_timer = resource_provider.get_node("%CoinDropTimer")

	func enter():
		super()
		coin_drop_timer.timeout.connect(_on_coin_drop_timer_timeout)
		state_animation_player.play("_idle")
		# Start timer with new wait time
		coin_drop_timer.wait_time = _get_coin_drop_wait_time()
		coin_drop_timer.start()

	func exit():
		# Stop timer when leaving idle state
		coin_drop_timer.timeout.disconnect(_on_coin_drop_timer_timeout)
		coin_drop_timer.stop()

	func _on_coin_drop_timer_timeout():
		state_machine.transition_to(state_machine.giving_coin_state)

	func _get_coin_drop_wait_time() -> float:
		var random_number_generator := RandomNumberGenerator.new()
		var random_int : float = float (random_number_generator.randi_range(-5, 5)) / 10
		var wait_time: float = resource_provider.seconds_per_coin + random_int
		return wait_time





#endregion

#region DeadState Inner CLass
class DeadState extends ResourceProviderState:
	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "DeadState"
	func enter():
		super()
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		if resource_provider.get_node("%StateAnimationPlayer").has_animation("_death"):
			resource_provider.get_node("%StateAnimationPlayer").play("_death")
		else:
			resource_provider.queue_free()

	func _on_state_animation_player_animation_finished(animation_name: String):
		if animation_name == "_death":
			resource_provider.queue_free()

	func can_receive_damage() -> bool:
		return false
	
	func exit():
		state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
#endregion

#region GivingCoinState Inner CLass
class SpawnState extends ResourceProviderState:
	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "SpawnState"
	func enter():
		super()
		state_animation_player.animation_finished.connect(_on_state_animation_player_animation_finished)
		if resource_provider.get_node("%StateAnimationPlayer").has_animation("spawn"):
			resource_provider.get_node("%StateAnimationPlayer").play("spawn")
		else:
			state_machine.transition_to(state_machine.idle_state)

	func _on_state_animation_player_animation_finished(animation_name: String):
		if animation_name == "spawn":
			state_machine.transition_to(state_machine.idle_state)

	func can_receive_damage() -> bool:
		return false

	func exit():
		state_animation_player.animation_finished.disconnect(_on_state_animation_player_animation_finished)
#endregion

#region GivingCoinState Inner CLass
class GivingCoinState extends ResourceProviderState:
	
	var coin_pksc : PackedScene = load("res://game_characters_scenes/components/ruble_coin/ruble_coin.tscn")

	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "GivingCoinState"
	func enter():
		super()
		state_animation_player.animation_changed.connect(_on_state_animation_player_animation_changed)
		resource_provider.get_node("%StateAnimationPlayer").play("_giving_coin")
		resource_provider.get_node("%StateAnimationPlayer").queue("_idle")

	func _on_state_animation_player_animation_changed(old_animation_name: String, _new_animation_name: String):
		if old_animation_name == "_giving_coin":
			state_machine.transition_to(state_machine.idle_state)

	func spawn_coin():
		var spawned_coin : RubleCoin
		spawned_coin = coin_pksc.instantiate() as RubleCoin
		spawned_coin.timer_wait_time = 2.0 if resource_provider.seconds_per_coin > 4 else 1.0
		spawned_coin.position = Vector2(-41, -135)
		resource_provider.add_child(spawned_coin)
	
	func exit():
		state_animation_player.animation_changed.disconnect(_on_state_animation_player_animation_changed)
#endregion
