class_name UDAlly extends Resource

@export var id : Ally.IDs

@export var unlocked_levels: Array[String]
@export var buyed_levels: Array[String]
@export var levels_conditions: Dictionary[AllyLevel, Dictionary]: set = _set_levels
@export var base_level: AllyLevel : set = _set_base_level

func _set_base_level(new_value: AllyLevel):
	base_level = new_value
	if !levels_conditions.has(base_level):
		levels_conditions[base_level] = {}
	if !unlocked_levels.has(base_level.level_id):
		unlocked_levels.append(base_level.level_id)

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
		if conditions.size() == 0 and !unlocked_levels.has(level.level_id): unlocked_levels.append(level.level_id)
		for condition in conditions:
			if !condition.fullfilled.is_connected(_on_condition_fullfilled.bind(level)):
				condition.fullfilled.connect(_on_condition_fullfilled.bind(level))

func _on_condition_fullfilled(condition: Condition, level: AllyLevel):
	var conditions = levels_conditions[level]
	conditions[condition] = true

	for _condition in conditions:
		if conditions[_condition] == false:
			return
	unlocked_levels.append(level.level_id)
	print(unlocked_levels)

func is_level_unlocked(level_id: String) -> bool:
	return unlocked_levels.has(level_id)

func is_level_buyed(level_id: String) -> bool:
	return buyed_levels.has(level_id)
