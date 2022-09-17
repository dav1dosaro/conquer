extends Area2D


export (String, FILE, "*.tscn") var LevelSelect

func _ready():
	get_node("Pic").play("Beat")

func _on_LevelTransfer_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_node("TransitionScreen/AnimationPlayer").play("Fade_In")
		pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_In":
		if get_tree().change_scene(LevelSelect)!= OK:
			print('An Error Occured')
