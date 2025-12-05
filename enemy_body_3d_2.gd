extends CharacterBody3D

const SPEED = 3.0

@onready var player = $"../Player"
@onready var animPlr = $AnimationPlayer

var isStunned = false

var health = 100

func windUp():
	print()

func getHurt():
	
	var dir = (position - player.position).normalized()
	velocity = dir * 50
	move_and_slide()
	
	isStunned = true
	health -= 30
	animPlr.play("Stun")
	isAlive()
	await get_tree().create_timer(.3).timeout
	isStunned = false
	
	

func move():
	var dir = (player.position - position)
	dir.y = 0
	dir = dir.normalized()	
	velocity = Vector3(dir.x, velocity.y, dir.z) * SPEED

func applyGravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func isAlive():
	if health <= 0:
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#print("a")
	
	applyGravity(delta)
	if not isStunned:
		move()
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y,0), 5)
	
	move_and_slide()
	isAlive()
	
