extends CanvasLayer

export (String, FILE, "*.tscn") var MainScene

func _ready(): 
	SceenScale()

func _on_BACK_pressed():
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		if get_tree().change_scene(MainScene)!= OK:
			print('An Error Occured')

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
	get_node("/root/GameData").set_setting("SETTINGS","MUSIC", value)
	get_node("/root/GameData").SaveValues()

func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),value)
	get_node("/root/GameData").set_setting("SETTINGS","SFX", value)
	get_node("/root/GameData").SaveValues()

func _on_UI_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"),value)
	get_node("/root/GameData").set_setting("SETTINGS","UI", value)
	get_node("/root/GameData").SaveValues()

func _on_Music_mouse_exited():
	get_node("Elements/Music").release_focus()


func _on_SFX_mouse_exited():
	get_node("Elements/SFX").release_focus()


func _on_UI_mouse_exited():
	get_node("Elements/UI").release_focus()

func SceenScale():
	if get_node("/root/GameData").get_setting("SETTINGS","FULLSCREEN") == true:
		get_node("Elements/Screen/Off").visible = true
		get_node("Elements/Screen/On").visible = false
		OS.window_fullscreen = true
	else:
		get_node("Elements/Screen/On").visible = true
		get_node("Elements/Screen/Off").visible = false
		OS.window_fullscreen = false


func _on_On_pressed():
	get_node("/root/GameData").set_setting("SETTINGS","FULLSCREEN", true)
	SceenScale()
	get_node("/root/GameData").SaveValues()


func _on_Off_pressed():
	get_node("/root/GameData").set_setting("SETTINGS","FULLSCREEN", false)
	SceenScale()
	get_node("/root/GameData").SaveValues()
