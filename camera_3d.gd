extends Camera3D

var strength = .1 #Strength of screen shake
var speed = 50 #How fast it ossilates
var time = 0.0 #Time since shake started

var friction = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func startShake(str) -> void:
	strength += str

func XscreenShake(dt) -> void: # dt is delta
	
	time += dt * speed
	position.x = sin(time) * strength
	strength -= (dt/friction)
	strength = clampf(strength,0, 2)
	
	if strength <= 0:
		time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("shake"):
		print("rah")
		startShake(.1)
	XscreenShake(delta)
	
	
