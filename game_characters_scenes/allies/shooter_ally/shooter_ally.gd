class_name ShooterAlly extends ScAlly

@onready var state_machine: ShooterAllyStateMachine

func _ready() -> void:
	state_machine = %ShooterAllyStateMachine

func receive_damage():
	state_machine.handle_damage()

func die():
	state_machine.handle_death()
