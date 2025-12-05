extends Area3D

@export var isPlayer = false

@export var hitID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("Attack"):
		#monitoring = not monitoring
		#if monitoring:
			#hitID = randf()
		#hitID = randf()
		pass
		
