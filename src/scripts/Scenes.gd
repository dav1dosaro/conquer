extends Node

onready var main_menu = preload("res://src/scenes/main/Main.tscn")
onready var splash_scene = preload("res://src/scenes/splash/Splash.tscn")
func _ready():
	pass

func add(scene, parent, pos = null):
	var obj = scene.instance()
	if pos != null:
		obj.global_position = pos
	Methods.add(parent,obj)

func add_menu(parent): add(main_menu, parent)
func add_splash(parent): add(splash_scene, parent)
