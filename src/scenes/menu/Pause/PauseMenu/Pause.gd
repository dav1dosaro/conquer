extends CanvasLayer

export (String, FILE, "*.tscn") var MainMenu

func _ready():
	self.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
	self.visible = get_tree().paused

func ButtonAudio():
	get_node("Elements/ButtonAudio").play()

func _on_Resume_pressed():
	ButtonAudio()
	get_tree().paused = false
	self.visible = get_tree().paused

func _on_Restart_pressed():
	ButtonAudio()
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print("SCENE RELOAD ERROR")

func _on_Menu_pressed():
	ButtonAudio()
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_Exit_pressed():
	ButtonAudio()
	get_tree().paused = false
	get_tree().quit()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		get_tree().paused = false
		if get_tree().change_scene(MainMenu)!= OK:
			print('An Error Occured')
