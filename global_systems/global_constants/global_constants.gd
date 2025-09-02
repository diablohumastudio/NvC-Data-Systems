extends Node

const TOTAL_NUMBER_OF_CANONS: int = 5

const SCREENS_UIDS: Dictionary = {
	"LOADING_SCREEN": "uid://b4n41kmtybwqn",
	"MAIN_MENU": "uid://cflg2ypu25js2",
	"SETTINGS_MENU": "uid://87lecky2hhq6",
	"ABOUT_MENU": "uid://bo1jforvfhnbv",
	"WORLDS_MAP_MENU": "uid://d3fq3n8sfelgm",
	"STALINGRAD_SUMMER_LEVELS_MENU":"uid://bnl38rkw31r66",
	"STALINGRAD_SUMMER_CAMP":"uid://ctww27adn5p47",
	"STALINGRAD_WINTER_LEVELS_MENU":"uid://gci4nehonton",
	
	"GAME": "uid://c2b4jldseu5vs",
	
	"MENU": "uid://iinlpvu7gc2e",
	"ACHIEVEMENTS": "uid://bbsi2yvced0xh",
	"WELCOME_MENU": "uid://iusscgq60rcy",
	"LOGIN_REGISTER_MENU": "uid://cxxmq32l3eqdc",
	"ALLIES_MARKET": "uid://d25cnc38vhdvn"
}

const DATA_FOLDERS_PATHS: Dictionary = {
	"RES_LEVELS":"res://data/levels/data/",
	"RES_ALLIES":"res://data/game_characters/allies/",
	"RES_ACHIEVEMENTS":"res://data/achievements/data/",
	"CONDITIONS":"res://data/acs_system/conditions/data/",
	"STATE_CHANGERS":"res://data/acs_system/state_changers/data/",
}

const ENEMIES_TYPES_UIDS: Dictionary[EnemyScene.TYPES, String] = {
	EnemyScene.TYPES.HandGunGerman: "uid://dq5mtgrma5krp"
}
