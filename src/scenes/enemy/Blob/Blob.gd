extends KinematicBody2D

enum EnemyStates {IDLE,CHASE,ATTACK,DEATH}
var States = EnemyStates.IDLE


func _ready():
	pass

func _process(delta):
	if States == EnemyStates.IDLE:
		pass
	elif States == EnemyStates.CHASE:
		pass
	elif States == EnemyStates.ATTACK:
		pass
	elif States == EnemyStates.DEATH:
		pass
	pass
