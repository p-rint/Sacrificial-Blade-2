extends CharacterBody3D

const isEnemy = true

var direction : Vector3
var input_dir : Vector2

@onready var plr = $"../../Player"
var origSPEED = randf_range(1, 2)
var SPEED = origSPEED
const JUMP_VELOCITY = 4.5

var isStunned = false

@onready var stunTimer = $Timers/Stun
@onready var atkCooldown = $Timers/AttackCooldown
@onready var atkRecovery = $Timers/AttackRecovery

@onready var model = $Character

@export var health = 100

var targetRot = 0

var isAttacking = false
var isRecover = false

#@onready var healthBar = $Sprite3D/SubViewport/HealthBar

@onready var AttackFuncs = $"../../GameFunctions/Attacks"


@onready var animPlr: AnimationPlayer = $AnimationPlayer
@onready var animTree: AnimationTree = $AnimationTree

var plrDist : int

var targetDist : int = 5

var approachDir = 1

@onready var hitboxes = $Character/Hitboxes

@onready var enemies: Node3D = $".."


func flatten(vector: Vector3) -> Vector3:
	return Vector3(vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, targetRot, .5)
	if direction and isStunned == false and isRecover == false:
		targetRot = atan2(-direction.x, -direction.z)
		velocity.x = direction.x * SPEED * approachDir
		velocity.z = direction.z * SPEED * approachDir
	else:
		velocity.x = move_toward(velocity.x, 0, 5)
		velocity.z = move_toward(velocity.z, 0, 5)
	animTree.set("parameters/Run/blend_position", approachDir * velocity.length()/5)

func isAlive():
	if health <= 0 or position.y < -20:
		queue_free()
		plr.energy += 3 + int(enemies.wave / 10.0)
		
func attackManage():
	if isAttacking:
		
		if plrDist < 2.5:
			isAttacking = false
			AttackFuncs.E_Atk1($".")
			atkRecovery.start(.6)
		
	else:
		if plrDist > targetDist: #if far
			approachDir = 1
			
			targetDist = 5
			
		else: #if real close
			if atkCooldown.time_left <= 0:
				approachDir = -1
				
				#AttackFuncs.E_Atk1($".")
				atkCooldown.start(1.0)
				targetDist = 12
			
func attackManage2():
	if isAttacking:
		SPEED = move_toward(SPEED, origSPEED + 10, .2)
		approachDir = 1
	else:
		SPEED = origSPEED
		
			
		
	


func _physics_process(delta: float) -> void:
	plrDist = position.distance_to(plr.position)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if plrDist > 10:
		move_and_slide()
		return
	#print(plrDist)
	
	attackManage() #ENABLE THESE 2 FOR ENEMY TO WORK			
	attackManage2()
	
	if stunTimer.time_left > 0:
		isStunned = true
	else:
		isStunned = false
		
	if atkRecovery.time_left > 0:
		isRecover = true
	else:
		isRecover = false
	
	#print(stunTimer.time_left)
	
	direction = (plr.position - position).normalized()
	move()
	
	isAlive()
	move_and_slide()
	
	if Input.is_action_just_pressed("ene"):
		#AttackFuncs.E_Atk1($".")
		pass
		
