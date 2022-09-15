extends KinematicBody2D


var speed = 400
onready var MAIN_SPEED =speed
var gravity = 30
var vel = Vector2.ZERO
var jump_height = 700
var dir = 0
var last_dir = 0


#variables
#jump
var jumping = false
var jump_count = 0
var MAX_JUMP = 2
#dash
var dashing = false
var dash_speed = 150

#attack
var attacking = false
var attack_count = 0

#nodes
onready var sprite = $Sprite
onready var state = $animations/AnimationTree.get("parameters/playback")
onready var aTree = $animations/AnimationTree
onready var raycast = $raycast/RayCast2D
onready var landTimer = $timers/landTimer
onready var dashTimer = $timers/dashTimer
onready var dashTrailTimer = $timers/dashTrail
onready var trail_holder = $trail_holder
onready var attack_timer = $timers/attackTimer

func _ready():
	aTree.active = true
	pass
	
func _process(delta):
	movement()
	jump()
	dash()
	attack()
	vel = move_and_slide(vel, Vector2.UP)
	pass

func movement():
	dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if !dashing and !attacking:
		vel.x = dir * speed
		vel.y += gravity
	
	#sprite flip
	if dir > 0 : 
		sprite.scale.x = 1
		last_dir = 1
	if dir < 0 : 
		sprite.scale.x = -1
		last_dir = -1
	if !jumping and !dashing and !attacking:
		if dir != 0:
			state.travel("run")
		else: state.travel("idle")
	

func jump():
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP:
		if jump_count > 0: state.travel("jump-flip")
		else: state.start("jump")
		$Timer.start()
		jumping = true
		jump_count += 1
		vel.y = -jump_height
		raycast.enabled = false
		landTimer.start()
	#landing
	if jumping and raycast.is_colliding() and vel.y >= 0:
		state.travel("land")
		raycast.enabled = false
		
	if is_on_floor():
		if vel.y >= 0:
			jump_count = 0
			jumping = false
	pass

func dash():
	if Input.is_action_just_pressed("dash") and !dashing and dir != 0:
		state.start("dash")
		dashing = true
		dashTimer.start()
		dashTrailTimer.start()
		vel.x = last_dir * speed * 5
#		Scenes.add_trail(get_parent().get_node("trail_holder"), position, sprite)
	pass

func attack():
	if Input.is_action_just_pressed("attack"):
		vel = Vector2.ZERO
		if attack_count <= 2:
			attack_timer.start()
		attacking = true
		attack_count += 1
		if is_on_floor():
			if attack_count > 0:
				state.start("attack")
			if attack_count > 1:
				state.travel("attack-2")
			if attack_count > 2:
				state.travel("attack-3")
#			attack_count = 0
		else:
			if attack_count > 0:
				state.start("jump-attack")
			if attack_count > 1:
				state.travel("jump-attack-2")
			if attack_count > 2:
				state.travel("jump-attack-3")
	pass

func revert_attack():
	attacking = false
	attack_count = 0
	pass
func revert_dash():
	speed = MAIN_SPEED
	dashing = false
	dashTrailTimer.stop()
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
	pass # Replace with function body.


func _on_dashTimer_timeout():
	revert_dash()
	pass # Replace with function body.


func _on_dashTrail_timeout():
	Scenes.add_trail(get_parent().get_node("trail_holder"), position, sprite)
	pass # Replace with function body.


func _on_attackTimer_timeout():
	revert_attack()
	pass # Replace with function body.
