extends Node

@export var uses_default_user: bool = false : set = _set_uses_default_user
var current_user_name: String = "DefltUser": set = _set_current_user_name
var conditions: Array[Condition]
var state_changers: Array[StateChanger] = _initialize_state_changers()

func get_saved_user_condition_by_id(id: String) -> Condition:
	for condition in conditions as Array[Condition]:
		if condition.id == id:
			return condition
	return null

func _set_uses_default_user(new_value: bool):
	uses_default_user = new_value
	if uses_default_user == true:
		conditions = _initialize_conditions()
		_save_conditions_to_user()

func _set_current_user_name(user_name: String):
	if uses_default_user == true: return
	assert(!user_name.is_empty(), "ACS Singleton should have a name. Parameter pass is empty. Malfunction espected")
	current_user_name = user_name
	conditions = _initialize_conditions()
	_save_conditions_to_user()

func _initialize_conditions() -> Array[Condition]:
	var _conditions: Array[Condition]
	var user_conditions_path = "user://" + current_user_name + "_conditions/"
	var user_dir := DirAccess.open(user_conditions_path)
	if user_dir != null and user_dir.get_files().size() > 0:
		_conditions = _load_conditions_from_user()
	else:
		_conditions  = _load_conditions_from_disk()
		
	return _conditions

func _initialize_state_changers() -> Array[StateChanger]:
	return _load_state_changers_from_disk()

func _load_conditions_from_disk() -> Array[Condition]:
	var conds: Array[Condition]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.CONDITIONS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		assert(cond != null, "Failed to load condition: " + file)
		conds.append(cond)
	return conds

func _load_conditions_from_user() -> Array[Condition]:
	var conds: Array[Condition]
	var user_conditions_path = "user://" + current_user_name + "_conditions/"
	var dir := DirAccess.open(user_conditions_path)
	assert(dir != null, "Could not open user conditions folder: " + user_conditions_path)
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		if cond != null:
			conds.append(cond)
	return conds

func _load_state_changers_from_disk() -> Array[StateChanger]:
	var state_changers_array: Array[StateChanger]
	var dir := DirAccess.open(GC.DATA_FOLDERS_PATHS.STATE_CHANGERS)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var state_changer: StateChanger = load(dir.get_current_dir() + "/" + file)
		assert(state_changer != null, "Failed to load state_changer: " + file)
		state_changers_array.append(state_changer)
	return state_changers_array

func set_action(action: Action):
	_call_state_changers(action)
	_evaluate_conditions(action)

func _call_state_changers(action: Action):
	for sc in state_changers:
		if sc.type == action.type:
			sc.change_state.call(action)

func _evaluate_conditions(action: Action):
	for cond in conditions:
		if cond.type == action.type:
			cond.evaluate(action)

	_save_conditions_to_user()

func _save_conditions_to_user():
	var user_conditions_path = "user://" + current_user_name + "_conditions/"
	# Create directory if it doesn't exist
	if not DirAccess.dir_exists_absolute(user_conditions_path):
		DirAccess.open("user://").make_dir_recursive(current_user_name + "_conditions")
	# Save each condition as individual .tres file
	for condition in conditions as Array[Condition]:
		var file_name = condition.id + ".tres"
		var result = ResourceSaver.save(condition, user_conditions_path + file_name)
		assert(result == OK, "Failed to save condition: " + file_name)
