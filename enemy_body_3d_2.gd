extends CharacterBody3D

const SPEED = 3.0

@onready var player = $"../Player"
@onready var animPlr = $AnimationPlayer

var isStunned = false

var health = 100

func windUp():
	print()

func flatenVector(vector : Vector3) -> Vector3:
	return Vector3(vector.x, 0 ,vector.z)

func move():
	var dir = (player.position - position)
	dir.y = 0
	dir = dir.normalized()	
	#velocity = Vector3(dir.x, velocity.y, dir.z) * SPEED
	velocity.x = dir.x * SPEED
	velocity.z = dir.z * SPEED
func applyGravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.1

func isAlive():
	if health <= 0:
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 5
	#print("a")
	
	applyGravity(delta)
	if not isStunned:
		move()
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y,0), 4)
		
	move_and_slide()
	isAlive()
	
