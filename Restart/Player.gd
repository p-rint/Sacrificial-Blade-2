extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2


const SPEED = 8.0
const JUMP_VELOCITY = 4.5

@onready var camPiv = $CamPivot

@onready var AttackFuncs = $"../GameFunctions/Attacks"

@onready var model = $Character

var dt : float


var targetRot = 0

@export var health = 99

@export var energy = 14


@onready var animPlr: AnimationPlayer = $AnimationPlayer
@onready var animTree: AnimationTree = $AnimationTree

@onready var quickSpinTimer: Timer = $Timers/QuickSpin

@onready var enemies: Node3D = $"../Enemies"


@export var targetEnemy : CharacterBody3D


func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, targetRot, .5)
	$CollisionShape3D.rotation.y = model.rotation.y
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, .15 * 2)
		velocity.z = lerp(velocity.z, direction.z * SPEED, .15 * 2)
		targetRot = atan2(-velocity.x, -velocity.z)
		#model.rotation.y = lerp_angle(model.rotation.y, atan2(-velocity.x, -velocity.z), .2)
	else:
		velocity.x = move_toward(velocity.x, 0, 5)
		velocity.z = move_toward(velocity.z, 0, 5)
	animTree.set("parameters/Run/blend_position", velocity.length()/SPEED)

func die():
	if health <= 0:
		energy -= 20

func quickSpin():
	
	velocity = flatten(camPiv.basis.z).normalized() * -30 + Vector3(0,velocity.y,0)
	

func _ready() -> void:
	targetEnemy = enemies.get_children().pick_random()

func _physics_process(delta: float) -> void:
	dt = delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	direction = flatten($CamPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move()
	
	if quickSpinTimer.time_left > 0:
		quickSpin()
		#print("eas")
	
	move_and_slide()
