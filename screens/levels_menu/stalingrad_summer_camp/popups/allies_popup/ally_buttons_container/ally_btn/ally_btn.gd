class_name AllyBtn extends TextureButton

const _SHOOTER_ALLIES_FOLDER_PATH : String = "res://screens/levels_menu/stalingrad_summer_camp/popups/allies_popup/assets/soldier_cards/"
const _RESOURCE_PROVIDERS_FOLDER_PATH : String = "res://screens/levels_menu/stalingrad_summer_camp/popups/allies_popup/assets/resource_providers_cards/"
const _OBSTRUCTERS_FOLDER_PATH : String = "res://screens/levels_menu/stalingrad_summer_camp/popups/allies_popup/assets/obstructers_cards/"
const _EXPLOSIVES_FOLDER_PATH : String = "res://screens/levels_menu/stalingrad_summer_camp/popups/allies_popup/assets/explosives_cards/"

var ally : AllyData : set = _set_ally
var ally_name : String #: set = _set_ally_name
var _normal_texture : Texture
var _hover_texture : Texture
var _pressed_texture : Texture
var _focused_texture : Texture

func _set_ally(new_value:AllyData) -> void:
	ally = new_value
	ally_name = ally.resource_name
	_set_textures()

func _get_ally_type_folder_path() -> String:
	var folder_path : String
	
	match ally.type:
		AllyData.TYPES.SHOOTER_ALLY:
			folder_path = _SHOOTER_ALLIES_FOLDER_PATH
		AllyData.TYPES.RESOURCE_PROVIDER:
			folder_path = _RESOURCE_PROVIDERS_FOLDER_PATH
		AllyData.TYPES.OBSTRUCTER:
			folder_path = _OBSTRUCTERS_FOLDER_PATH
		AllyData.TYPES.EXPLOSIVE:
			folder_path = _EXPLOSIVES_FOLDER_PATH
	
	return folder_path

func _set_textures() -> void:
	var textures : Array[Texture] = get_textures_from_files()
	for texture in textures:
		if texture.resource_path.ends_with("hover.png"):
			_hover_texture = texture
		elif texture.resource_path.ends_with("selected.png"):
			_pressed_texture = texture
			_focused_texture = texture
		else: 
			_normal_texture = texture
	
	texture_normal = _normal_texture
	texture_pressed = _pressed_texture
	texture_hover = _hover_texture
	texture_focused = _focused_texture
	
	
func get_textures_from_files() -> Array[Texture]:
	var textures : Array[Texture]
	var ally_type_folder_path : String = _get_ally_type_folder_path()
	
	var dir := DirAccess.open(ally_type_folder_path)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		if file.begins_with(ally_name) and !file.ends_with(".import"):
			textures.append(load(ally_type_folder_path + "/" + file))
	return textures
