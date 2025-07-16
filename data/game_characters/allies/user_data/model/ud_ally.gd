class_name UDAlly extends Resource

@export var id : Ally.IDs

@export var levels_conditions: Dictionary[AllyLevel, Dictionary]: set = _set_levels

func _set_levels(new_value: Dictionary[AllyLevel, Dictionary]):
	if levels_conditions:
		for level in levels_conditions:
			var conditions = levels_conditions[level]
			for condition in conditions:
				if condition.fullfilled.is_connected(_on_condition_fullfilled.bind(level)):
					condition.fullfilled.disconect(_on_condition_fullfilled.bind(level))

	levels_conditions = new_value
	for level in levels_conditions:
		var conditions = levels_conditions[level]
		for condition in conditions:
			if !condition.fullfilled.is_connected(_on_condition_fullfilled.bind(level)):
				condition.fullfilled.connect(_on_condition_fullfilled.bind(level))

func _on_condition_fullfilled(condition: Condition, level: AllyLevel):
	var conditions = levels_conditions[level]
	conditions[condition] = true

	for _condition in conditions:
		if conditions[_condition] == false:
			return
	level.locked = false

func is_level_unlocked(level_id: String) -> bool:
	var level: AllyLevel
	for _level in levels_conditions:
		if _level.level_id == level_id:
			level = _level

	var conditions = levels_conditions[level]
	for condition in conditions:
			print(conditions[condition])
			if !conditions[condition]:
				return false
	return true
