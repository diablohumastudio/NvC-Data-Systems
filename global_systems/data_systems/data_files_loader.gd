class_name DataFilesLoader extends Node

static func get_levels_from_res_files() -> Array[LevelData]:
	var levels: Array[LevelData]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_LEVELS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var level: LevelData = load(dir.get_current_dir() + "/" + file)
		assert(level != null, "Failed to load achievement: " + file)
		levels.append(level)
	return levels

static func get_achievements_from_res_files() -> Array[AchievementData]:
	var achievements: Array[AchievementData]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var achievement: AchievementData = load(dir.get_current_dir() + "/" + file)
		assert(achievement != null, "Failed to load achievement: " + file)
		achievements.append(achievement)
	return achievements

static func get_achiev_from_res_file_by_id(id: AchievementData.IDs) -> AchievementData:
	var achievement: AchievementData = load(GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS + AchievementData.IDs.keys()[id] + ".tres")
	assert(achievement != null, GC.DATA_FOLDERS_PATHS.RES_ACHIEVEMENTS + AchievementData.IDs.keys()[id] + ".tres")
	return achievement

static func get_allies_from_res_files() -> Array[AllyData]:
	var allies: Array[AllyData]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.RES_ALLIES)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for ally_type_folder : String in dir.get_directories():
		if ally_type_folder == "models": continue
		dir.change_dir(GC.DATA_FOLDERS_PATHS.RES_ALLIES +ally_type_folder)
		for ally_folder : String in dir.get_directories():
			if ally_folder == "models": continue
			dir.change_dir(GC.DATA_FOLDERS_PATHS.RES_ALLIES + ally_type_folder + "/" + ally_folder)
			for file: String in dir.get_files():
				var ally: AllyData = load(dir.get_current_dir() + "/" + file)
				assert(ally != null, "Failed to load ally: " + file)
				allies.append(ally)
	return allies

static func get_allies_from_res_file_by_id(id: AllyData.IDs) -> AllyData:
	var file_name:String = (AllyData.IDs.keys()[id] as String).to_lower()
	var ally: AllyData = load(GC.DATA_FOLDERS_PATHS.RES_ALLIES + file_name + ".tres")
	assert(ally != null, GC.DATA_FOLDERS_PATHS.RES_ALLIES + file_name + ".tres")
	return ally
