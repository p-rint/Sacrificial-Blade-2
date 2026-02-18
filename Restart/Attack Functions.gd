extends Node

@onready var Player = $"../../Player"
@onready var Model = $"../../Player/Character"
@onready var Skeleton = $"../../Player/Character/Armature/Skeleton3D"
@onready var plrHitboxes = $"../../Player/Character/Hitboxes"
@onready var plrVFX = $"../../Player/Character/VFX"
@onready var Projectiles = $"../../Projectiles"

@onready var box = preload("res://Restart/Hitbox.tscn")
@onready var slash = preload("res://Restart/VFX/slash_vfx.tscn")

@onready var reactions = $"../Reactions"

var comboNum = 0

var comboSet = [Atk1, Atk2, Atk3]

@onready var comboTimer = $Timers/Combo

@onready var quickSpinTimer: Timer = $Timers/QuickSpin


func combo() -> void:
	if comboNum < comboSet.size() and comboTimer.time_left > 0:
		comboSet[comboNum].call()
		comboNum += 1
	else:
		comboSet[0].call()
		comboNum = 1
	comboTimer.start(1)

func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func newSlash() ->  Node3D: #newHitbox
	var slash = slash.instantiate()
	plrVFX.add_child(slash)
	return (slash)

func newHB(function : Callable) -> Area3D: #newHitbox
	var hitbox = box.instantiate()
	hitbox.reaction = function
	plrHitboxes.add_child(hitbox)
	return (hitbox)

func EnewHB(function : Callable, enemy : CharacterBody3D) -> Area3D: #newHitbox
	var hitbox = box.instantiate()
	hitbox.reaction = function
	enemy.hitboxes.add_child(hitbox)
	return (hitbox)
	
func checkEnergy(num : int) -> bool:
	if Player.energy >= num:
		Player.energy -= num
		return(true)
	else:
		$"../../UI/AnimationPlayer".play("energy none")
		return(false)
	


func Atk1() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -30
	var hitbox = newHB(reactions.Atk1)
	hitbox.scale.z = 3
	hitbox.position.z = -1.5
	#newSlash()
	
	Player.animTree.set("parameters/attack1/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func Atk2() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -40
	var hitbox = newHB(reactions.Atk2)
	hitbox.scale.z = 3
	hitbox.position.z = -1.5
	
	Player.animTree.set("parameters/attack2/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func Atk3() -> void:
	Player.velocity = flatten(Player.camPiv.basis.z) * -55
	var hitbox = newHB(reactions.Atk3)
	hitbox.scale.z = 3
	hitbox.position.z = -1.5
	
	Player.animTree.set("parameters/attack3/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func Lunge() -> void:
	Player.animTree.set("parameters/lunge/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	await get_tree().create_timer(.1).timeout
	Player.velocity = flatten(Player.camPiv.basis.z) * -18
	var hitbox = newHB(reactions.Lunge)
	

func Uppercut() -> void:
	Player.animTree.set("parameters/uppercut/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	await get_tree().create_timer(.1).timeout
	var hitbox = newHB(reactions.Uppercut)




func Quickspin() -> void:
	Player.animTree.set("parameters/quickspin/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	
	await get_tree().create_timer(.2).timeout
	Player.quickSpinTimer.start(.3)
	#Player.velocity = flatten(Player.camPiv.basis.z) * -20
	Player.velocity.y = 5
	
	var hitbox = newHB(reactions.Quickspin)
	
	await get_tree().create_timer(.2).timeout
	
	Player.velocity.y = 5
	var hitbox2 = newHB(reactions.Quickspin)


func Quickcut() -> void:
	Player.animTree.set("parameters/quickcut/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	await get_tree().create_timer(.1).timeout
	Player.velocity = flatten(Player.camPiv.basis.z).normalized() * -100
	var hitbox = newHB(reactions.Quickcut)

func Jumpspin() -> void:
	Player.animTree.set("parameters/jumpspin/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	
	
	await get_tree().create_timer(.08).timeout
	#Player.velocity = flatten(Player.camPiv.basis.z) * -20
	Player.velocity.y = 10
	var hitbox = newHB(reactions.Jumpspin)
	
	await get_tree().create_timer(.8).timeout
	
	Player.velocity.y = 8
	var hitbox2 = newHB(reactions.Jumpspin)
	
	await get_tree().create_timer(.5).timeout
	
	Player.velocity.y = 5
	var hitbox3 = newHB(reactions.Jumpspin)
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		combo()
	
	if Input.is_action_just_pressed("Lunge") and checkEnergy(3):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Lunge()
	
	if Input.is_action_just_pressed("Uppercut") and checkEnergy(4): # Uppercut
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Uppercut()
	
	if Input.is_action_just_pressed("Quickspin") and checkEnergy(7):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Quickspin()
		
	if Input.is_action_just_pressed("Quickcut") and checkEnergy(25):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Quickcut()
	
	if Input.is_action_just_pressed("Jumpspin") and checkEnergy(14):
		Player.targetRot = atan2(Player.camPiv.basis.z.x, Player.camPiv.basis.z.z)
		Jumpspin()
		
	





func E_Atk1(enemy : CharacterBody3D) -> void: # enemy is enemy
	enemy.velocity = enemy.direction * -10
	var hitbox = EnewHB(reactions.E_Atk1, enemy) #change newHB so it becomes a parent of enemy
	hitbox.scale.z = 5
	hitbox.position.z = -2.5
	
	enemy.animTree.set("parameters/attack1/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
