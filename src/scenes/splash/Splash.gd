extends CanvasLayer

func _init_scene():
	Methods.delete(self)
	Scenes.add_menu(get_parent())
