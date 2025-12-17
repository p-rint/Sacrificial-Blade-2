extends Node

#Extra variables

@onready var character = $"../Player"
@onready var camPivot = $"../Player/CamPivot"


@onready var playerContainer = $"../Player/PlayerContainer"
@onready var EnemyHurtManager = $"../Player/EnemyHurtManager"

@onready var attackTimer = character.get_node("Timers/Attacking")

var CamDir = Vector3(0,0,0)
@export var curAttack : Dictionary

#Extra functions

func setCamDir():
	CamDir = camPivot.global_basis.z
	CamDir.y = 0
	CamDir = CamDir.normalized()


#Main variables
var Attack = {"MoveDistance" : 20, "KnockbackDist" : 30, "Damage" : 10, "Func" : Atk1}
var Attack2 = {"MoveDistance" : 20,"KnockbackDist" : 30, "Damage" : 10, "Func" : Atk2}
var Attack3 = {"MoveDistance" : 20, "KnockbackDist" : 30, "Damage" : 15, "Func" : Atk3}
var Attack4 = {"MoveDistance" : 2, "KnockbackDist" : 30, "YKnockbackDist" : 7, "Damage" : 20, "Func" : Atk4}


var Lunge = {"MoveDistance" : 40, "KnockbackDist" : 50, "Damage" : 30, "Func" : lunge}
var QuickSpin = {"MoveDistance" : 50, "YMoveDistance" : 4, "KnockbackDist" : 20, "Damage" : 20, "Func" : quickSpin}

#Attack functions
func Atk1():
	curAttack = Attack
	character.velocity = CamDir * -Attack["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	attackTimer.start(.2)

func Atk2():
	curAttack = Attack2
	character.velocity = CamDir * -Attack2["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	attackTimer.start(.2)
	

func Atk3():
	curAttack = Attack3
	character.velocity = CamDir * -Attack3["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	
func Atk4():
	curAttack = Attack4
	character.velocity.y = Attack4["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)

func lunge():
	curAttack = Lunge
	await get_tree().create_timer(.2).timeout
	character.velocity = CamDir * -Lunge["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	print("ewe")
	
func quickSpin():
	curAttack = QuickSpin
	await get_tree().create_timer(.1).timeout
	character.velocity = CamDir * -QuickSpin["MoveDistance"]
	character.velocity.y = QuickSpin["YMoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	#playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	setCamDir()
	
