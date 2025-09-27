class_name AllyBtn extends TextureButton

const _BTNS_TEXTURES_FOLDER_PATH : String = "res://screens/levels_menu/stalingrad_summer_camp/popups/barracks_popup/assets/soldier_cards/"

var ally_name : String : set = _set_ally_name
var _normal_texture : Texture
var _hover_texture : Texture
var _pressed_texture : Texture
var _focused_texture : Texture

func _set_ally_name(new_value:String) -> void:
	ally_name = new_value
	_set_textures()

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
	var dir := DirAccess.open(_BTNS_TEXTURES_FOLDER_PATH)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		if file.begins_with(ally_name) and !file.ends_with(".import"):
			textures.append(load(_BTNS_TEXTURES_FOLDER_PATH + "/" + file))
	return textures
