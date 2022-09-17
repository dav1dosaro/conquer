extends Node2D


var Cloud_3_Speed

func _ready():
	randomize()
	Cloud_3_Speed = rand_range(300, 350)

func _process(delta):
	$Cloud1.scroll_base_offset -= Vector2(0,0)
	$Cloud2.scroll_base_offset -= Vector2(0,0)
	$Cloud3.scroll_base_offset -= Vector2(Cloud_3_Speed,0) * delta
