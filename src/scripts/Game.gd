extends Node2D
export var splash_on = true
export var test = true

func _ready():
	if splash_on: Scenes.add_splash(self)
	else: 
		if test: Scenes.add_test(self)
		else: Scenes.add_menu(self)
	pass
