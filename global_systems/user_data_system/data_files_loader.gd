class_name DataFilesLoader extends Node

static func create_ud_levels_from_res_files() -> Array[UDLevel]:
	var _ud_levels: Array[UDLevel]
	var dir := DirAccess.open("res://data/ud_levels/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: UDLevel = load(dir.get_current_dir() + "/" + file)
		_ud_levels.append(ud_level.duplicate())
	return _ud_levels

static func create_ud_achievements_from_res_files() -> Array[UDAchievement]:
	var _ud_levels: Array[UDAchievement]
	var dir := DirAccess.open("res://data/ud_achievements/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: UDAchievement = load(dir.get_current_dir() + "/" + file)
		_ud_levels.append(ud_level.duplicate())
	return _ud_levels

static func get_achievements_from_res_files() -> Array[Achievement]:
	var achievements: Array[Achievement]
	var dir := DirAccess.open("res://data/achievements/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: Achievement = load(dir.get_current_dir() + "/" + file)
		achievements.append(ud_level)
	return achievements

static func get_conditions_from_res_files() -> Array[Condition]:
	var conds: Array[Condition]
	var dir := DirAccess.open("res://data/conditions/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		conds.append(cond)
	return conds

static func get_state_changer_from_res_files() -> Array[StateChanger]:
	var state_changers: Array[StateChanger]
	var dir := DirAccess.open("res://data/state_changers/data/")
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var state_changer: StateChanger = load(dir.get_current_dir() + "/" + file)
		state_changers.append(state_changer)
	return state_changers
