class_name CondEnemKillTot extends Condition

@export var enemies_to_kill : int = 0

func _init() -> void:
	type = Action.TYPES.ENEMY_KILLED

func evaluate(_action: Action):
	if UDS.get_property(UDS.PROPERTIES.ENEMIES_KILLED) >= enemies_to_kill:
		fullfilled.emit(self)
