class_name DataFilesLoader extends Node

# Cache for frequently used small resources
static var _conditions_cache: Array[Condition]
static var _state_changers_cache: Array[StateChanger]

static func create_ud_levels_from_res_files() -> Array[UDLevel]:
	var _ud_levels: Array[UDLevel]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.UD_LEVELS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_level: UDLevel = load(dir.get_current_dir() + "/" + file)
		assert(ud_level != null, "Failed to load ud_level: " + file)
		_ud_levels.append(ud_level.duplicate())
	return _ud_levels

static func create_ud_achievements_from_res_files() -> Array[UDAchievement]:
	var _ud_levels: Array[UDAchievement]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.UD_ACHIEVEMENTS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_achievement: UDAchievement = load(dir.get_current_dir() + "/" + file)
		assert(ud_achievement != null, "Failed to load ud_achievement: " + file)
		_ud_levels.append(ud_achievement.duplicate())
	return _ud_levels

static func create_ud_allies_from_res_files() -> Array[UDAlly]:
	var _ud_allies: Array[UDAlly]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.UD_ALLIES)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ud_ally: UDAlly = load(dir.get_current_dir() + "/" + file)
		assert(ud_ally != null, "Failed to load ud_ally: " + file)
		_ud_allies.append(ud_ally.duplicate())
	return _ud_allies

static func get_achievements_from_res_files() -> Array[Achievement]:
	var achievements: Array[Achievement]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var achievement: Achievement = load(dir.get_current_dir() + "/" + file)
		assert(achievement != null, "Failed to load achievement: " + file)
		achievements.append(achievement)
	return achievements

static func get_achiev_from_res_file_by_id(id: Achievement.IDs) -> Achievement:
	var achievement: Achievement = load(GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS + Achievement.IDs.keys()[id] + ".tres")
	assert(achievement != null, GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS + Achievement.IDs.keys()[id] + ".tres")
	return achievement

static func get_allies_from_res_files() -> Array[Ally]:
	var allies: Array[Ally]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_ALLIES)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var ally: Ally = load(dir.get_current_dir() + "/" + file)
		assert(ally != null, "Failed to load ally: " + file)
		allies.append(ally)
	return allies

static func get_conditions_from_res_files() -> Array[Condition]:
	if _conditions_cache.is_empty():
		_conditions_cache = _load_conditions_from_disk()
	return _conditions_cache

static func _load_conditions_from_disk() -> Array[Condition]:
	var conds: Array[Condition]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.CONDITIONS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		assert(cond != null, "Failed to load condition: " + file)
		conds.append(cond)
	return conds

static func get_state_changer_from_res_files() -> Array[StateChanger]:
	if _state_changers_cache.is_empty():
		_state_changers_cache = _load_state_changers_from_disk()
	return _state_changers_cache

static func _load_state_changers_from_disk() -> Array[StateChanger]:
	var state_changers: Array[StateChanger]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.STATE_CHANGERS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var state_changer: StateChanger = load(dir.get_current_dir() + "/" + file)
		assert(state_changer != null, "Failed to load state_changer: " + file)
		state_changers.append(state_changer)
	return state_changers
