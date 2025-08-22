class_name ResourceProvider extends ScAlly

@export var resource_value: int
@export var seconds_per_coin: float

@onready var state_machine: ResourceProviderStateMachine

func _ready() -> void:
	super()
	state_machine = %ResourceProviderStateMachine

# This function here so it can be called by StateAnimationPlayer call_method track interface
func _spawn_coin():
	state_machine.giving_coin_state._spawn_coin()

func receive_damage():
	state_machine.handle_damage()

func die():
	state_machine.handle_death()
