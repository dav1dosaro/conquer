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
export var attack_distance = 70

func _ready():
	get_node("Body").visible = true
	get_node("Explosion").visible = false
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
			get_node("Body").play("Idle")
			pass
		elif Dis2 > chase_distance and Dis2 < Idle_distance:
			States = EnemyStates.CHASE
			get_node("Body").play("Walk")
			pass
		elif Dis2 < attack_distance:
			States = EnemyStates.ATTACK
			get_node("Body").play("Attack")
			pass
	pass

func idle():
	velocity.x = 0
	pass

func Chase():
	velocity.x = Speed

func Attack():
	velocity.y = -325
	get_node("Body").visible = false
	get_node("Explosion").play("Explosion")
	get_node("AnimationPlayer").play("ATK")
	attack = true
	pass

func _on_Explosion_animation_finished():
	if get_node("Explosion").animation == "Explosion":
		self.queue_free()
