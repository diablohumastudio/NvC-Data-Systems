class_name CondEnemKillLevel extends Condition

@export var enemies_to_kill : int = 0

func _init() -> void:
	type = Action.TYPES.ENEMY_KILLED

func evaluate(action: Action):
	var payload : Action.PayEnemKilled = action.payload
	var killed_enemied: int = payload.killed_enemies
	if killed_enemied >= enemies_to_kill:
		fullfilled.emit(self)
