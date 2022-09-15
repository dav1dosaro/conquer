extends KinematicBody2D

enum EnemyStates {IDLE,CHASE,ATTACK}
var States = EnemyStates.IDLE

var PlayerLoc
export var Player_Path : NodePath

var gravity = 10
var velocity = Vector2(0,0)
export var Speed = 70
export var Health = 3
export var attack = false


export var Idle_distance = 400
export var chase_distance = 300
export var attack_distance = 100

func _ready():
	PlayerLoc = get_node(Player_Path)
	pass

func _process(delta):
	if States == EnemyStates.IDLE:
		idle()
		pass
	elif States == EnemyStates.CHASE:
		Chase()
		pass
	elif States == EnemyStates.ATTACK:
		if attack == false:
			Attack()
		pass
	
	velocity.y += gravity
	velocity = move_and_slide(velocity,Vector2.UP)
	
	
	
	
	var PLoc = PlayerLoc.position
	var Dis2 = self.position.distance_to(PLoc)
	
	if PlayerLoc.is_on_floor():
		if Dis2 > Idle_distance:
			States = EnemyStates.IDLE
			print("IDLE")
			pass
		elif Dis2 > chase_distance and Dis2 < Idle_distance:
			States = EnemyStates.CHASE
			print("CHASE")
			pass
		elif Dis2 < attack_distance:
			States = EnemyStates.ATTACK
			print("ATTACK")
			pass
	pass


func idle():
	velocity.x = 0
	pass

func Chase():
	velocity.x = Speed

func Attack():
	velocity.y = -350
	attack = true
	pass

