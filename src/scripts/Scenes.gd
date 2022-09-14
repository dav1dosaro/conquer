extends Node

onready var main_menu_scene = preload("res://src/scenes/main/Main.tscn")
onready var splash_scene = preload("res://src/scenes/splash/Splash.tscn")
onready var test_scene = preload("res://src/scenes/test/Test.tscn")
onready var dash_trail_scene = preload("res://src/scenes/others/trail/Trail.tscn")
func _ready():
	pass

func add(scene, parent, pos = null, sprite = null):
	var obj = scene.instance()
	if pos != null:
		obj.global_position = pos
	if sprite != null:
		obj.get_node("Sprite").texture = sprite.texture
		obj.get_node("Sprite").offset = sprite.offset
		
		obj.get_node("Sprite").scale = sprite.scale
	Methods.add(parent,obj)

func add_menu(parent): add(main_menu_scene, parent)
func add_splash(parent): add(splash_scene, parent)
func add_test(parent): add(test_scene, parent)
func add_trail(parent, pos, texture): add(dash_trail_scene, parent, pos, texture)
