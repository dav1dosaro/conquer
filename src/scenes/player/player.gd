extends KinematicBody2D


var speed = 400
var gravity = 30
var vel = Vector2.ZERO
var jump_height = 700
var dir = 0


#variables
var jump = false
var jump_count = 0
var MAX_JUMP = 2

#nodes
onready var sprite = $Sprite
onready var state = $animations/AnimationTree.get("parameters/playback")
onready var aTree = $animations/AnimationTree
onready var raycast = $raycast/RayCast2D
onready var landTimer = $timers/landTimer

func _ready():
	aTree.active = true
	pass
	
func _physics_process(delta):
	movement()
	jump()
	pass

func movement():
	dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vel.x = dir * speed
	vel.y += gravity
	vel = move_and_slide(vel, Vector2.UP)
	
	#sprite flip
	if dir > 0 : sprite.flip_h = false
	if dir < 0 : sprite.flip_h = true
	if !jump:
		if dir != 0:
			state.travel("run")
		else: state.travel("idle")
	

func jump():
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP:
		aTree.set("parameters/jump/blend_position", 0)
		state.start("jump")
		$Timer.start()
		jump = true
		jump_count += 1
		vel.y = -jump_height
		raycast.enabled = false
		landTimer.start()
	
	if jump and raycast.is_colliding() and vel.y >= 0:
		state.start("jump")
		aTree.set("parameters/jump/blend_position", 1)
		raycast.enabled = false
		
	if is_on_floor():
		if vel.y >= 0:
			jump_count = 0
			jump = false
	pass

func _input(event):
	pass


func _on_Timer_timeout():
#	state.start("jump")
#	aTree.set("parameters/jump/blend_position", 1)
#	print("yes")
#	print(aTree.get("parameters/jump/blend_position"))
	pass # Replace with function body.


func _on_landTimer_timeout():
	raycast.enabled = true
	print("yes")
	pass # Replace with function body.
