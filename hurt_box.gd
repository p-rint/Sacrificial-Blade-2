extends Area3D

var IDs = []

@onready var EnemyHurtManager = $"../../../../Hurts"

@onready var AttackData = $"AttackData"

@onready var enemy = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func hitCheck(area : Area3D): #make sure hitbox not already hit
	for i in IDs:
		if i == area.hitID: #If the area was already detected
			return( false )
		
	IDs.append(area.hitID)
	return true # no matches	
	

func _on_area_entered(area: Area3D) -> void:
	if area.monitoring == true:
		
		if hitCheck(area):
			print("entered")
			#get_parent().get_parent().get_parent().getHurt()
			EnemyHurtManager.Hurt1(enemy)
			#AttackData["EnemyFunc"].call()
