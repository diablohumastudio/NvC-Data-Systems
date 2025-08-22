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

func handle_animation_finished(animation_name: String):
	if current_state:
		current_state.handle_animation_finished(animation_name)

func handle_damage():
	if current_state and current_state.can_receive_damage():
		if resource_provider.has_node("%ReceiveDamage"):
			resource_provider.get_node("%ReceiveDamage").play("_receive_damage_general")

func handle_death():
	transition_to(dead_state)

func is_busy() -> bool:
	return current_state == giving_coin_state or current_state == spawn_state or current_state == dead_state

#endregion

#region BaseState Inner Class
class ResourceProviderState extends RefCounted:
	var name: String
	var resource_provider: ResourceProvider
	var state_machine: ResourceProviderStateMachine

	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		resource_provider = provider
		state_machine = machine

	func enter():
		pass

	func exit():  
		pass

	func update(_delta: float):
		pass

	func handle_coin_timer_timeout():
		pass

	func handle_animation_finished(_animation_name: String):
		pass

	func can_receive_damage() -> bool:
		return true

class IdleState extends ResourceProviderState:
	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "IdleState"
	func enter():
		super()
		resource_provider.get_node("%CoinDropTimer").timeout.connect(handle_coin_timer_timeout)
		resource_provider.get_node("%StateAnimationPlayer").play("_idle")
		# Start timer with new wait time
		resource_provider.get_node("%CoinDropTimer").wait_time = _get_coin_drop_wait_time()
		resource_provider.get_node("%CoinDropTimer").start()

	func exit():
		# Stop timer when leaving idle state
		resource_provider.get_node("%CoinDropTimer").timeout.disconnect(handle_coin_timer_timeout)
		resource_provider.get_node("%CoinDropTimer").stop()

	func handle_coin_timer_timeout():
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
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_finished.connect(handle_animation_finished)
		if resource_provider.get_node("%StateAnimationPlayer").has_animation("_death"):
			resource_provider.get_node("%StateAnimationPlayer").play("_death")
		else:
			resource_provider.queue_free()

	func handle_animation_finished(animation_name: String):
		if animation_name == "_death":
			resource_provider.queue_free()

	func can_receive_damage() -> bool:
		return false
	
	func exit():
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_finished.disconnect(handle_animation_finished)
#endregion

#region GivingCoinState Inner CLass
class SpawnState extends ResourceProviderState:
	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "SpawnState"
	func enter():
		super()
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_finished.connect(handle_animation_finished)
		if resource_provider.get_node("%StateAnimationPlayer").has_animation("spawn"):
			resource_provider.get_node("%StateAnimationPlayer").play("spawn")
		else:
			state_machine.transition_to(state_machine.idle_state)

	func handle_animation_finished(animation_name: String):
		if animation_name == "spawn":
			state_machine.transition_to(state_machine.idle_state)

	func can_receive_damage() -> bool:
		return false

	func exit():
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_finished.disconnect(handle_animation_finished)
#endregion

#region GivingCoinState Inner CLass
class GivingCoinState extends ResourceProviderState:
	
	var coin_pksc : PackedScene = load("res://game_characters_scenes/components/ruble_coin/ruble_coin.tscn")

	func _init(provider: ResourceProvider, machine: ResourceProviderStateMachine):
		super(provider, machine)
		name = "GivingCoinState"
	func enter():
		super()
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_changed.connect(handle_animation_changed)
		resource_provider.get_node("%StateAnimationPlayer").play("_giving_coin")
		resource_provider.get_node("%StateAnimationPlayer").queue("_idle")

	func handle_animation_changed(old_animation_name: String, _new_animation_name: String):
		if old_animation_name == "_giving_coin":
			state_machine.transition_to(state_machine.idle_state)

	func _spawn_coin():
		var spawned_coin : RubleCoin
		spawned_coin = coin_pksc.instantiate() as RubleCoin
		spawned_coin.timer_wait_time = 2.0 if resource_provider.seconds_per_coin > 4 else 1.0
		spawned_coin.position = Vector2(-41, -135)
		resource_provider.add_child(spawned_coin)
	
	func exit():
		(resource_provider.get_node("%StateAnimationPlayer") as AnimationPlayer).animation_changed.disconnect(handle_animation_changed)
#endregion
