extends CanvasLayer

export (String, FILE, "*.tscn") var ContinueGame
export (String, FILE, "*.tscn") var NewGame
export (String, FILE, "*.tscn") var Back

var SceneSwitch = 1

func _ready():
	SceneSwitch = 1

func _on_Continue_pressed():
	SceneSwitch = 1
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_NewGame_pressed():
	SceneSwitch = 2
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_Back_pressed():
	SceneSwitch = 3
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		if SceneSwitch == 1:
			if get_tree().change_scene(ContinueGame)!= OK:
				print('An Error Occured')
		if SceneSwitch == 2:
			if get_tree().change_scene(NewGame)!= OK:
				print('An Error Occured')
		if SceneSwitch == 3:
			if get_tree().change_scene(Back)!= OK:
				print('An Error Occured')
