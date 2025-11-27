extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var direction = Vector3(0,0,0) # Movedirection

@onready var animPlr = $AnimationPlayer
@onready var animTree = $AnimationTree

@onready var enemyMesh = $MeshInstance3D

var isSprinting = false

var canAttack = true

var windingUp = false

var canChangeState = true

var backingUp = false

var isStunned = false

@onready var player = $"../CharacterBody3D"

var canDash = true

var canMove = true

func getHit() -> void:
	velocity.z = -10

func windUp() -> void:
	windingUp = true
	await get_tree().create_timer(1).timeout
	#print("WACK!!!")
	attack()

func attack() -> void:
	animPlr.play("Attack")
	#enemyMesh.rotation.x += 20

func getTime() -> void:
	print(Engine.time_scale)


func stateManage() -> void:
	if canChangeState == true:
		#print("a")
		canChangeState = false
		await get_tree().create_timer(.7).timeout
		canChangeState = true
		backingUp = not backingUp
	
func dash() -> void:
	var dir = (player.position - position).normalized()

	if canDash == true:
		velocity = dir * 10
		canDash = false
		canMove = false
		await get_tree().create_timer(.4).timeout
		canMove = true
		#print("canb mrovwdew")
		await get_tree().create_timer(.6).timeout
		canDash = true
		#print("adfqedx")
	

	

func backUp() -> void:
	if backingUp == true:
		if direction:
			velocity.x = -direction.x
			velocity.z = -direction.y
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	

func jump() -> void:
	
	if is_on_floor():
		velocity.y = JUMP_VELOCITY * randf_range(.8,1.1)
		await get_tree().create_timer(.5).timeout

func prep() -> void:
	#print( position.distance_to(player.position))
	var dist =  position.distance_to(player.position)
	if dist <= 5:
		#print("good to atk")
		if canAttack == true:
			#print("ASACfade")
			canAttack = false
			await windUp()
			#await get_tree().create_timer(.5).timeout
			canAttack = true
	#var dist = (player.position - position)

func lookAtPlayer() -> void:
	var toPlr = (position - player.position)
	var lookDir = Vector2(toPlr.x, toPlr.z).angle()
	
	var deg = deg_to_rad(lookDir)
	
	enemyMesh.rotation.x = lookDir
	#print(lookDir)
	

func move() -> void:
	if canMove:
		if direction:
			velocity.x = (direction.x * (SPEED))
			velocity.z = (direction.z * (SPEED))	
				
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("Left","Right", "Up", "Down")
	#direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = (player.position - position).normalized()
	
	
	if isStunned == false:
		move()
		backUp()
	
	#animTree.set("parameters/MoveDirection/blend_position", Vector2(direction.x, -direction.z))
	lookAtPlayer()
	#prep()
	#jump()
	stateManage()
	#getTime()
	#dash()
	move_and_slide()
