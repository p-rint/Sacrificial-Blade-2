extends Node

@onready var player = $"../Player"
@onready var dirToPlayer = Vector3(0,0,0)

func Hurt1(enemy : CharacterBody3D):
	dirToPlayer = (enemy.position - player.position).normalized()
	enemy.velocity = dirToPlayer * 50
	enemy.move_and_slide()
	
	enemy.isStunned = true
	enemy.health -= 30
	enemy.animPlr.play("Stun")
	
	await get_tree().create_timer(.3).timeout
	if is_instance_valid(enemy):
		enemy.isStunned = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
