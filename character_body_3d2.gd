extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5

var curSpeed = 0

@onready var cam = $CamPivot
@onready var PlayerContainer = $PlayerContainer
var camForward = Vector3()
var camRight = Vector3()

var camDir = Vector3(0,0,0) #Where the camera is facing

var direction = Vector3(0,0,0) # Movedirection

var lastDirection = Vector3(0,0,0)

var isSprint = false

var canMove = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func move(delta):
	if direction:	
		lastDirection = direction
		var moveDir = ((camRight * direction.x) + (camForward * direction.z)) * curSpeed
		velocity.x = moveDir.x
		velocity.z = moveDir.z
		
		if isSprint == true:
			curSpeed = move_toward(curSpeed, SPEED + 4, delta*100)
		else:
			curSpeed = move_toward(curSpeed, SPEED, delta*100)
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		curSpeed = move_toward(curSpeed,0, SPEED)
	print(curSpeed)

func lookDir(delta : float):
	if direction:
		var angle = atan2(-velocity.x, -velocity.z)
		var finalRot = lerpf(PlayerContainer.rotation.y, angle, 1)
		PlayerContainer.rotation.y = finalRot 


func dash() -> void:
	velocity.z = -40


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	camForward = cam.global_basis.z.normalized()
	camRight = cam.global_basis.x.normalized()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir = Input.get_vector("Left","Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("Dash"):
		isSprint = true
	else:
		isSprint = false
	
	if Input.is_action_just_pressed("Dash"):
		dash()
	
	move(delta)
	lookDir(delta)
	move_and_slide()
