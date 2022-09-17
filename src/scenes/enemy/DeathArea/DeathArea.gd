extends Area2D





func _on_DeathArea_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_tree().reload_current_scene()
