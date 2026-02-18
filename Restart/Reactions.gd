extends Node

@onready var plr = $"../../Player"

func flatten(vec : Vector3):
	return Vector3(vec.x, 0, vec.z)

func stun(enemy : CharacterBody3D, time) -> void:
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(time)
	
	enemy.animTree.set("parameters/stunAir/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
	enemy.animTree.set("parameters/stun/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func stunAir(enemy : CharacterBody3D, time) -> void:
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(time)
	
	enemy.animTree.set("parameters/stun/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
	enemy.animTree.set("parameters/stunAir/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func Atk1(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, .3)
	enemy.velocity = dir * 30
	enemy.health -= 25
	
func Atk2(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, .5)
	enemy.velocity = dir * 40
	enemy.health -= 25
	
func Atk3(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, 1)
	enemy.velocity = dir * 55
	enemy.health -= 50

func Lunge(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, 1.5)
	enemy.velocity = dir * 60
	
	enemy.health -= 30

func Uppercut(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stunAir(enemy, 1)
	enemy.velocity.y = 8
	enemy.health -= 33

func Quickspin(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, 1)
	#enemy.velocity = dir * 60
	enemy.velocity = -flatten(plr.camPiv.basis.z) * 60
	enemy.health -= 25

func Quickcut(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	stun(enemy, 1.5)
	enemy.velocity = dir * 20
	
	enemy.health -= 200

func Jumpspin(enemy : CharacterBody3D) -> void:
	enemy.velocity.y = plr.velocity.y + 1
	stunAir(enemy, 1)
	enemy.health -= 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func E_Atk1(enemy : CharacterBody3D) -> void:
	
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = plr.get_node("Timers/Stun")
	stunTimer.start(.3)
	plr.velocity = -dir * 10
	plr.health -= 10
	plr.targetRot = atan2(-dir.x,-dir.z)
	
	plr.animTree.set("parameters/stun/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
