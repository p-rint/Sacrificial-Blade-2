extends Node

@onready var plr = $"../../../Player"

func flatten(vec : Vector3):
	return Vector3(vec.x, 0, vec.z)

func Atk1(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(.3)
	enemy.velocity = dir * 30
	
func Atk2(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(.5)
	enemy.velocity = dir * 40
	
func Atk3(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(1)
	enemy.velocity = dir * 55

func Lunge(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(1.5)
	enemy.velocity = dir * 60

func Uppercut(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(1)
	enemy.velocity.y = 8

func Quickspin(enemy : CharacterBody3D) -> void:
	var dir = flatten(enemy.position - plr.position).normalized()
	var stunTimer : Timer = enemy.get_node("Timers/Stun")
	stunTimer.start(1)
	enemy.velocity = dir * 40


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
