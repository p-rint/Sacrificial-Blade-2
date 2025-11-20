extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const DASHSPEED = 45.0

var camDir = Vector3(0,0,0) #Where the camera is facing

var direction = Vector3(0,0,0) # Movedirection

var dashVel = 0

func dash(dir : Vector3) -> void:
	
	
	dashVel = DASHSPEED #or wherever the player is facing
	velocity.z = DASHSPEED
		#move_and_slide()


func _physics_process(delta: float) -> void:
	
	var camRight = $CamPivot.global_transform.basis.x
	var camForward = $CamPivot.global_transform.basis.z
	camDir = (camRight + camForward).normalized()
	#print(camRight)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left","Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = (direction.x * (SPEED + dashVel))
		velocity.z = (direction.z * (SPEED + dashVel))	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	dashVel = move_toward(dashVel, 0, SPEED)
	
	if Input.is_action_just_pressed("Dash"):
		dash(direction)

	move_and_slide()
