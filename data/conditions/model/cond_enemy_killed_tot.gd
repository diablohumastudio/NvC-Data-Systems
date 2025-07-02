class_name CondEnemKillTot extends Condition

@export var enemies_to_kill : int = 0

func _init(_enemies_to_kill: int = 0) -> void:
	type = Action.TYPES.ENEMY_KILLED
	enemies_to_kill = _enemies_to_kill

func evaluate(action: Action):
	var payload : Action.PayEnemKilled = action.payload
	var killed_enemied: int = payload.killed_enemies
	if killed_enemied >= enemies_to_kill:
		fullfilled.emit(self)
