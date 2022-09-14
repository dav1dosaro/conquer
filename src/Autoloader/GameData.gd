extends Node

enum {LOAD_SUCCESS, LOAD_ERROR_COULDNT_OPEN}

const SAVE_PATH = "res://src/Data/Game_Data.cfg"

var _config_file = ConfigFile.new()

var Character = {
	"PLAYER":{
		"HEALTH" : 100,
		"MANA" : 100
	},
	"SETTINGS": {
		"FULLSCREEN": true,
		"MUSIC": -80,
		"SFX": -80,
		"UI": -80
	}
}

func _ready():
	LoadValues()

func SaveValues():
	for section in Character.keys():
		for key in Character[section].keys():
			# The ConfigFile object (_config_file is a ConfigFile) has all the methods you need to load, save, set and read values
			_config_file.set_value(section, key, Character[section][key])

	_config_file.save(SAVE_PATH)


func LoadValues():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Error loading the settings. Error code: %s" % error)
		return LOAD_ERROR_COULDNT_OPEN

	for section in Character.keys():
		for key in Character[section].keys():
			var val = _config_file.get_value(section,key)
			Character[section][key] = val
	return LOAD_SUCCESS


func get_setting(category, key):
	return Character[category][key]

func set_setting(category, key, value):
	Character[category][key] = value
