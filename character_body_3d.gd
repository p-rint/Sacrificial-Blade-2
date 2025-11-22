extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const DASHSPEED = 45.0

var curSpeed = 0

var camDir = Vector3(0,0,0) #Where the camera is facing

var direction = Vector3(0,0,0) # Movedirection

var dashVel = 0

var sprintSpeed = 5 #Total speed is 10, but just so I can add it to speed

var comboNum = 0
var attackTable = [attack, attack2, attack3, attack4, attack5, attack6]
var attackAnimTable = ["Attack", "Attack2", "Attack3"]

@onready var animPlr = $AnimationPlayer
@onready var animTree = $AnimationTree

var isSprinting = false

func comboManager() -> void:
	if comboNum < attackAnimTable.size():
		#attackTable[comboNum].call()
		animPlr.play(attackAnimTable[comboNum])
		
		#if comboNum > 0:
			#animTree.set("parameters/" + attackAnimTable[comboNum - 1] + "/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
		
		animTree.set("parameters/" + attackAnimTable[comboNum] + "/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		print(comboNum)
		comboNum += 1
		
	else:
		animPlr.play(attackAnimTable[0])
		comboNum = 1


func dash(dir : Vector3) -> void:
	
	if dir:
		dashVel = DASHSPEED #or wherever the player is facing
	else:
		velocity.z = DASHSPEED
		#move_and_slide()
	animTree.set("parameters/Dash/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func attack() -> void:
	#$"Character Model".get_active_material(0).set_shader_parameter("t", 0.0)
	velocity.z = -10

func attack2() -> void:
	velocity.z = 50
	velocity.y = 20
	await get_tree().create_timer(.1).timeout
	velocity.y = 1
	
func attack3() -> void:
	velocity.z = -50
	velocity.y = -40
	
func attack4() -> void:
	velocity.z = -30
	velocity.x = -30
	await get_tree().create_timer(.07).timeout
	velocity.z = -30
	velocity.x = 30
	await get_tree().create_timer(.05).timeout
	velocity.z = -30
	velocity.x = -30
	await get_tree().create_timer(.05).timeout
	velocity.z = -30
	velocity.x = 30

func attack5() -> void:
	velocity.y = 40
	await get_tree().create_timer(.1).timeout
	velocity.y /= 10
	
func attack6() -> void:
	velocity.y = -60




func _physics_process(delta: float) -> void:
	
	var camRight = $CamPivot.global_transform.basis.x
	var camForward = $CamPivot.global_transform.basis.z
	camDir = (camRight + camForward).normalized()
	#print(camDir)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Attack"):
		#attack()
		comboManager()
		
	if Input.is_action_pressed("Dash"):
		sprintSpeed = 2
	else: 
		sprintSpeed = 0
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left","Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = (direction.x * (SPEED + dashVel + sprintSpeed))
		velocity.z = (direction.z * (SPEED + dashVel + sprintSpeed))	
		
		#velocity = camDir
		
		curSpeed = move_toward(curSpeed,5, SPEED)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		curSpeed = move_toward(curSpeed,0, SPEED)
	dashVel = move_toward(dashVel, 0, SPEED)
	
	animTree.set("parameters/MoveDirection/blend_position", Vector2(direction.x, -direction.z))
	
	
	if Input.is_action_just_pressed("Dash"):
		dash(direction)

	move_and_slide()
