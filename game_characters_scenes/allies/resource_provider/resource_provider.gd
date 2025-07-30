class_name ResourceProvider extends ScAlly

@export var resource_value: int
@export var seconds_per_coin: float

@onready var state_machine: ResourceProviderStateMachine

func _ready() -> void:
	state_machine = %ResourceProviderStateMachine
	print(state_machine)

func _spawn_coin():
	state_machine._spawn_coin()

func receive_damage():
	state_machine.handle_damage()

func die():
	state_machine.handle_death()
