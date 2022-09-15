extends CanvasLayer

export (String, FILE, "*.tscn") var StoryScene
export (String, FILE, "*.tscn") var OptionsScene
export (String, FILE, "*.tscn") var ControlScene

var SceneSwitch = 1

func _ready():
	get_node("/root/GameData").SaveValues()
	SceneSwitch = 1
	OneTimeSettingsRetrieval()

func OneTimeSettingsRetrieval():
	OS.window_fullscreen = get_node("/root/GameData").get_setting("SETTINGS","FULLSCREEN")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), get_node("/root/GameData").get_setting("SETTINGS","MUSIC"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), get_node("/root/GameData").get_setting("SETTINGS","SFX"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"), get_node("/root/GameData").get_setting("SETTINGS","UI"))


func _on_Story_pressed():
	SceneSwitch = 1
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_Options_pressed():
	SceneSwitch = 2
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_Controls_pressed():
	SceneSwitch = 3
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		if SceneSwitch == 1:
			if get_tree().change_scene(StoryScene)!= OK:
				print('An Error Occured')
		if SceneSwitch == 2:
			if get_tree().change_scene(OptionsScene)!= OK:
				print('An Error Occured')
		if SceneSwitch == 3:
			if get_tree().change_scene(ControlScene)!= OK:
				print('An Error Occured')


func _on_Exit_pressed():
	get_tree().quit()



