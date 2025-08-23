class_name SocialMediaBtn extends TextureButton

const _X_ICON_PATH : String = "uid://cod3m65v4jnff"
const _STEAM_ICON_PATH : String = "uid://b7evrb3jrwdql"
const _INSTAGRAM_ICON_PATH : String = "uid://dq48hhb85ed7n"
const _FACEBOOK_ICON_PATH : String = "uid://byfufgasdqr38"

enum TYPES {X, FACEBOOK, INSTAGRAM, STEAM} 

var type:TYPES

func set_button(user_name:String):
	%Title.text = user_name
	
	match type:
		TYPES.X:
			%Icon.texture = load(_X_ICON_PATH)
		TYPES.STEAM:
			%Icon.texture = load(_STEAM_ICON_PATH)
		TYPES.INSTAGRAM:
			%Icon.texture = load(_INSTAGRAM_ICON_PATH)
		TYPES.FACEBOOK:
			%Icon.texture = load(_FACEBOOK_ICON_PATH)
