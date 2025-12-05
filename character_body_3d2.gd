extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5

const DASHSPEED = 30

var curSpeed = 0

@onready var cam = $CamPivot
@onready var PlayerContainer = $PlayerContainer
var camForward = Vector3()
var camRight = Vector3()

var camDir = Vector3(0,0,0) #Where the camera is facing

var direction = Vector3(0,0,0) # Movedirection

var lastDirection = Vector3(0,0,0)

var lastMoveDir = Vector3(0,0,0)

var isSprint = false

var canMove = true

var isDash = false

var moveDir = Vector3(0,0,0)

var forwardDir = Vector3()

@onready var rayCast = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func move(delta):
	if direction:	
		lastDirection = direction
		moveDir = ((camRight * direction.x) + (camForward * direction.z))
		
		moveDir.y = 0
		moveDir = moveDir.normalized()
		
		velocity.x = moveDir.x * curSpeed
		velocity.z = moveDir.z * curSpeed
		
		lastMoveDir = moveDir
		
		lookDir(delta)
		
		if isSprint == true:
			curSpeed = move_toward(curSpeed, SPEED + 4, delta*100)
		else:
			curSpeed = move_toward(curSpeed, SPEED, delta*100)
			
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y,0), SPEED)
		curSpeed = move_toward(curSpeed,0, SPEED)
#	print(curSpeed)

func lookDir(delta :float):
	if direction:
		var angle = atan2(-moveDir.x, -moveDir.z)
		var finalRot = lerpf(PlayerContainer.rotation.y, angle, .5)
		PlayerContainer.rotation.y = angle 


func dash() -> void:
	var newDir
	
	if direction: #forward dash
		newDir = -moveDir
		PlayerContainer.rotation.y = atan2(newDir.x,newDir.z)
	else: # backwards dash
		
		newDir = -camForward
		PlayerContainer.rotation.y = atan2(-newDir.x,-newDir.z)
	
	newDir.y = 0
	newDir = newDir.normalized()
	velocity = newDir * -DASHSPEED
		#print(newDir)
		
		
	curSpeed = DASHSPEED
	
	isDash = true
	await get_tree().create_timer(.1).timeout
	#velocity = Vector3(0,0,0)
	isDash = false
	#print("End")

func surfaceAlign() -> void:
	var normalDir = rayCast.get_collision_normal()
	var newBasisY = normalDir
	var newBasisX = -PlayerContainer.basis.z.cross(PlayerContainer.basis.y)
	#var newBasis = Vector3(newBasisX, newBasisY, basis.z).orth
	var newBasis =  Basis(newBasisX, normalDir, PlayerContainer.basis.z).orthonormalized()
	PlayerContainer.basis = newBasis
	#rayCast.position = -basis.y * 5
	print(PlayerContainer.basis.z * 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	camForward = cam.global_basis.z
	camRight = cam.global_basis.x
	
	camDir = cam.global_basis.z + cam.global_basis.x
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir = Input.get_vector("Left","Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#print(direction)
	if Input.is_action_pressed("Dash"):
		isSprint = true
	else:
		isSprint = false
	
	if Input.is_action_just_pressed("Dash"):
		dash()
	if not isDash:
		move(delta)
	
	surfaceAlign()
		
	move_and_slide()
