extends Node3D

var children

var enemy = preload("res://Restart/enemy.tscn")

var wave = 0

var endWave = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	children = get_children()

func spawnEnemy() -> void:
	var newEnemy = enemy.instantiate()
	newEnemy.position = Vector3(randf_range(-20,20),3, randf_range(-20,20))
	add_child(newEnemy)
	
	
func startWave() -> void:
	wave += 1
	for i in randf_range(1,3):
		spawnEnemy()
	endWave = false
	if wave > 1:
		$"../Player".health += 35
	

func _on_enemy_attack_timeout() -> void: 
	if children.size() > 0:
		var ene = randi_range(0, children.size() - 1)
		var enemy = children[ene]
		
		if not is_instance_valid(enemy) or enemy.is_queued_for_deletion():
			return
		
		if enemy.isStunned == false:
			enemy.isAttacking = true
			pass
	else:
		if endWave == false:
			endWave = true
			#startWave()
		
	
	
	
	pass # Replace with function body.
