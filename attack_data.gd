extends Node

#Extra variables

@onready var character = $"../Player"
@onready var camPivot = $"../Player/CamPivot"


@onready var playerContainer = $"../Player/PlayerContainer"
@onready var EnemyHurtManager = $"../Player/EnemyHurtManager"

var CamDir = Vector3(0,0,0)


#Extra functions

func setCamDir():
	CamDir = camPivot.global_basis.z
	CamDir.y = 0
	CamDir = CamDir.normalized()


#Main variables
var Attack = {"MoveDistance" : 40, "Func" : Atk1}
var Attack2 = {"MoveDistance" : 50, "Func" : Atk2}
var Attack3 = {"MoveDistance" : 70, "Func" : Atk3}
var Attack4 = {"MoveDistance" : 10, "Func" : Atk4}

#Attack functions
func Atk1():
	character.velocity = CamDir * -Attack["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)

func Atk2():
	character.velocity = CamDir * -Attack2["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)

func Atk3():
	character.velocity = CamDir * -Attack3["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)
	
func Atk4():
	character.velocity.y = Attack4["MoveDistance"]
	playerContainer.rotation.y = atan2(CamDir.x,CamDir.z)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	setCamDir()
	
