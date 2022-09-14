extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0,0)
var Moving_Right = true

export var Speed = 32
export var Health = 1
export var Enemy_Attack_damage = 1
export var Wall_Smarts = false
export var Push_Back_Force = 1.0

onready var Floor_Raycast = get_node("Floor_Ray")
onready var Wall_Raycast = get_node("Wall_Ray")

func _ready():
	if Wall_Smarts == true:
		Wall_Raycast.enabled = true
	else:
		Wall_Raycast.enabled = false

func _process(_delta):
	Health = clamp(Health,0,1)
	Move()
	Detect_Floor()
	if Wall_Smarts == true:
		Detect_Wall()

func Move():
	if Moving_Right == true:
		velocity.x = Speed
	else:
		velocity.x = -Speed
	
	velocity.y += gravity
	
	velocity = move_and_slide(velocity,Vector2.UP)

func Detect_Floor():
	if not Floor_Raycast.is_colliding() and is_on_floor():
		Moving_Right = !Moving_Right
		scale.x = -scale.x

func Detect_Wall():
	if Wall_Raycast.is_colliding():
		Moving_Right = !Moving_Right
		scale.x = -scale.x

func Health_Detail(Enemy_Health_damage):
	get_node("TimerHolder/HitTimer").start()
	get_node("Body").material.set_shader_param("Flash_modifier",1)
	Health -= Enemy_Health_damage
	global_position -= Vector2(velocity.x,velocity.y) * Push_Back_Force
	Die()

func Die():
	if Health == 0:
		get_node("Death").play()
		get_node("Body").play("Death")
		get_node("TimerHolder/DeathTimer").start()

func _on_Timer_timeout():
	get_node("Body").material.set_shader_param("Flash_modifier",0)

func _on_Body_animation_finished():
	if get_node("Body").animation == "Attack":
		for H in get_node("HitArea").get_overlapping_bodies():
			H.Health_Detail(Enemy_Attack_damage)
			get_node("Attack").play()
			get_node("TimerHolder/AttackTimer").start()
	
	if get_node("Body").animation == "Death":
		self.global_position = self.global_position
		set_process(false)
		get_node("HitArea/CollisionShape2D").disabled = true
		get_node("CollisionShape2D").disabled = true
		Floor_Raycast.enabled = false
		Wall_Raycast.enabled = false

func _on_DeathTimer_timeout():
	queue_free()


func _on_HitArea_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_node("Body").play("Attack")

func _on_HitArea_body_exited(body):
	if body.is_in_group("PLAYER"):
		get_node("TimerHolder/AttackTimer").start()

func _on_AttackTimer_timeout():
	queue_free()
