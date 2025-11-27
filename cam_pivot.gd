extends Node3D

var mouseLock = true

@onready var enemy = $"../../EnemyBody3D2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.
	

func lockAt() -> void:
	var dir = (global_position - enemy.position )
	var angle = Vector2(dir.x, dir.z).angle()
	
	#print(angle)
	
	pass 
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#print("a")
		#print(event.relative.x)
		rotation.y -= event.relative.x * .001 #Left <-> Right
		rotation.x -= event.relative.y * .001 #Up <-> Down
		
		rotation.y = wrapf(rotation.y, -PI, PI)
		rotation.x = clampf(rotation.x,-PI/2,PI/2)
		
		#print(rotation.x)
		#print(-PI/2)
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Escape"):
		if mouseLock:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouseLock = not mouseLock
	#lockAt()
	
	
	#if Input.is_action_just_pressed("LockOn"):
	
		
