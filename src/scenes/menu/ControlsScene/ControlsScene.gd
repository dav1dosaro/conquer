extends CanvasLayer

export (String, FILE, "*.tscn") var MainScene

func _on_BACK_pressed():
	get_node("Elements/TransitionScreen/AnimationPlayer").play("Fade_In")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		if get_tree().change_scene(MainScene)!= OK:
			print('An Error Occured')
