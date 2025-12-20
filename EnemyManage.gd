extends Node3D

var enemy = preload("res://enemy_body_3d_2.tscn")

@export var wave = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await get_tree().create_timer(1).timeout
	spawnEnemy()
	#$"../Timer".connect("timeout", spawnEnemy)

func spawnEnemy():
	var newEnemy = enemy.instantiate()
	newEnemy.position = Vector3(randf_range(0,10),2.5,randf_range(0,10))
	add_child(newEnemy)

func waveManager():
	if get_children().size() == 0:
		for i in randf_range(1,5):
			spawnEnemy()
		wave += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	waveManager()
	pass
