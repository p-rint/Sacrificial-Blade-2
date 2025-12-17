extends Node

@onready var player = $"../Player"
@onready var dirToPlayer = Vector3(0,0,0)

@onready var attackData = $"../AttackData"

func flatenVector(vector : Vector3) -> Vector3:
	return Vector3(vector.x, 0 ,vector.z)


func Hurt1(enemy : CharacterBody3D):
	player.strength += 3
	#print(attackData.curAttack)
	var curAttack = attackData.curAttack
	print(curAttack)
	
	dirToPlayer = flatenVector(enemy.position - player.position).normalized()
	enemy.velocity = dirToPlayer * curAttack["KnockbackDist"]
	
	if curAttack.has("YKnockbackDist"):
		enemy.velocity.y = curAttack["YKnockbackDist"]
		print("ad")
	enemy.move_and_slide()
	
	enemy.isStunned = true
	enemy.health -= curAttack["Damage"]
	enemy.animPlr.play("Stun")
	
	enemy.rotation.y = atan2(dirToPlayer.x, dirToPlayer.z)
	enemy.get_node("HitVFX/Sparks").emitting = true
	
	await get_tree().create_timer(.3).timeout
	if is_instance_valid(enemy):
		enemy.isStunned = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
