extends Node2D
export var splash_on = true

func _ready():
	if splash_on: Scenes.add_splash(self)
	else: Scenes.add_menu(self)
	pass
