extends Area3D

@export var isPlayer = true

@export var hitID = 0

@export var currentAttack : Dictionary

@onready var animPlr = $"../../AnimationPlayer"

var comboNum = 0

var attacks = ["Attack", "Attack2", "Attack3", "Attack4"]

@onready var AttackData = $"../../../AttackData"

var oldMonitoring = monitoring

func comboManager() -> void:
	$"../..".strength -= 1
	animPlr.stop()
	if comboNum >= attacks.size():
		comboNum = 0
		
	
	var atkName = attacks[comboNum]
	currentAttack = AttackData[atkName]
	
	animPlr.play(atkName)
	AttackData[atkName]["Func"].call()
	AttackData.curAttack = currentAttack
	comboNum += 1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Attack"):
		comboManager()
		monitoring = false
		
		#hitID = randf()
		
	if Input.is_action_just_pressed("Lunge"):
		print("Lun")
		animPlr.stop()
		#animPlr.play("RESET")
		#currentAttack = AttackData["Lunge"]
		animPlr.play("Lunge")
		AttackData["Lunge"]["Func"].call()
		
	if Input.is_action_just_pressed("QuickSpin"):
		print("QS")
		animPlr.stop()
		#animPlr.play("RESET")
		#currentAttack = AttackData["Lunge"]
		animPlr.play("QuickSpin")
		AttackData["QuickSpin"]["Func"].call()
	
	if oldMonitoring != monitoring:
		hitID = randf()
		oldMonitoring = monitoring
	
