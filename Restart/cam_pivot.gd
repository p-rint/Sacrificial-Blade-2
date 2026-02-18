extends Node3D

var dt : float

var mouseLock = false

var camOffset = Vector3(0,3.388, 2.354)
var camRotOffset = Vector3(-31.1,0.0,0.0)

@onready var camBase : Node3D = $"../../CameraBase"

@onready var camera : Camera3D = $"../../CameraBase/Camera3D"

@onready var player: CharacterBody3D = $".."

@onready var enemies: Node3D = $"../../Enemies"


var isLockedOn = false

var minLockDist = 4
var maxLockDist = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#DON'T DO TS
	Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not mouseLock:
		
		
		rotation.y -= event.relative.x * .001 #Left <-> Right
		rotation.x -= event.relative.y * .001 #Up <-> Down
		
		rotation.y = wrapf(rotation.y, -PI, PI)
		rotation.x = clampf(rotation.x,-PI/2,PI/2)
	
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	
	if event.is_action_pressed("Tab"):
		print("AAAA")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_released("Tab"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
	if Input.is_action_just_pressed("LockOn"):
		isLockedOn = not isLockedOn
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt = delta
	camBase.position = global_position# + camOffset
	camBase.rotation_degrees = global_rotation_degrees# + camRotOffset
	
	
	if isLockedOn:
		if player.targetEnemy:
			lockOn()
		else:
			chooseEnemy()
		
					
func lockOn() -> void:
	var toEnemy = (player.position - player.targetEnemy.position)
	var targetAngle = atan2(toEnemy.x,toEnemy.z)
	
	var dist = toEnemy.length()
	
	var lerpStrength = move_toward(20, 5, dist)
	# Min dist is 4, max amt 10
	# Min multiplier is 5, max amt 20
	var lerpAmt = dt * lerpStrength	
	print(dist)
	if dist > .5:
		rotation.y = lerp_angle(rotation.y, targetAngle, lerpAmt)
	




func flatten(vec : Vector3) -> Vector3:
	return (vec * Vector3(1,0,1))
	



func chooseEnemy():
	player.targetEnemy = enemies.get_children().pick_random()
	
