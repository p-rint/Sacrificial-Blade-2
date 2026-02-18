extends Node3D

@onready var VFX = $".." #all vfx


var time = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Lifetime.start(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("AAA")


func _on_lifetime_timeout() -> void:
	queue_free()
