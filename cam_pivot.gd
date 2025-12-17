extends Node3D

var mouseLock = true


@onready var target = $"../../Target"

@onready var enemies = $"../../Enemies"

@onready var curTarget = target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.
	

func lockOn() -> void:
	if is_instance_valid(curTarget):
		#look_at(curTarget.position)
		pass
	else:
		if enemies.get_children().size() >= 0:
			curTarget = enemies.get_child( randf_range(0, enemies.get_children().size()) )
		else:
			curTarget = target
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
	lockOn()
	if Input.is_action_just_pressed("Escape"):
		if mouseLock:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouseLock = not mouseLock
	#lockAt()
	
	if Input.is_action_just_pressed("LTarget"):
		if enemies.get_children().size() >= 0:
			curTarget = enemies.get_child( randf_range(0, enemies.get_children().size()) )
		else:
			curTarget = target
	#if Input.is_action_just_pressed("LockOn"):
	
		
