class_name DataFilesLoader extends Node

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
		var duplic_ud_ally : UDAlly = ud_ally.duplicate()
		_ud_allies.append(duplic_ud_ally)
	return _ud_allies

static func get_levels_from_res_files() -> Array[Level]:
	var levels: Array[Level]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_LEVELS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var level: Level = load(dir.get_current_dir() + "/" + file)
		assert(level != null, "Failed to load achievement: " + file)
		levels.append(level)
	return levels

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

static func get_allies_from_res_file_by_id(id: Ally.IDs) -> Ally:
	var file_name:String = (Ally.IDs.keys()[id] as String).to_lower()
	var ally: Ally = load(GC.DATA_FOLDERS_PATHS.RES_ALLIES + file_name + ".tres")
	assert(ally != null, GC.DATA_FOLDERS_PATHS.RES_ALLIES + file_name + ".tres")
	return ally
