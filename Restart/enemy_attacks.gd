extends Node

@onready var Enemy = $"../../Player"
@onready var plrHitboxes = $"../../Player/Character/Hitboxes"
@onready var Projectiles = $"../../Projectiles"

@onready var box = preload("res://Restart/Hitbox.tscn")


@onready var reactions = $"../Reactions"

var comboNum = 0

var comboSet = [Atk1, Atk2, Atk3]

	

func combo() -> void:
	if comboNum < comboSet.size() and $Combo.time_left > 0:
		comboSet[comboNum].call()
		comboNum += 1
	else:
		comboSet[0].call()
		comboNum = 1
	$Combo.start(1)

func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)


func newHB(function : Callable) -> Area3D: #newHitbox
	var hitbox = box.instantiate()
	hitbox.reaction = function
	plrHitboxes.add_child(hitbox)
	return (hitbox)


func Atk1() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -10
	var hitbox = newHB(reactions.Atk1)
	hitbox.scale.z = 5
	hitbox.position.z = -2.5
	
	Player.animPlr.stop()
	Player.animPlr.play("1")

func Atk2() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -10
	var hitbox = newHB(reactions.Atk2)
	Player.animPlr.stop()
	Player.animPlr.play("2")
	
func Atk3() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -15
	var hitbox = newHB(reactions.Atk3)
	Player.animPlr.stop()
	Player.animPlr.play("3")

func Lunge() -> void:
	Player.animPlr.stop()
	Player.animPlr.play("Lunge")
	
	await get_tree().create_timer(.1).timeout
	Player.velocity = flatten(Player.camPiv.basis.z) * -18
	var hitbox = newHB(reactions.Lunge)
	

func Uppercut() -> void:
	Player.animPlr.stop()
	Player.animPlr.play("Uppercut")
	
	await get_tree().create_timer(.1).timeout
	var hitbox = newHB(reactions.Uppercut)


func Quickspin() -> void:
	Player.animPlr.stop()
	Player.animPlr.play("Quickspin")
	
	await get_tree().create_timer(.2).timeout
	Player.velocity = flatten(Player.camPiv.basis.z) * -18
	Player.velocity.y = 5
	
	var hitbox = newHB(reactions.Quickspin)
	
	await get_tree().create_timer(.2).timeout
	var hitbox2 = newHB(reactions.Quickspin)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		combo()
	
	if Input.is_action_just_pressed("Lunge"):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Lunge()
	
	if Input.is_action_just_pressed("Uppercut"): # Uppercut
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Uppercut()
	
	if Input.is_action_just_pressed("Quickspin"):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Quickspin()
