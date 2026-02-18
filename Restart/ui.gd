extends CanvasLayer

@onready var health: Label = $Health
@onready var energy: Label = $Energy
@onready var wave: Label = $Wave


@onready var player: CharacterBody3D = $"../Player"

@onready var enemies: Node3D = $"../Enemies"

@onready var fire: ColorRect = $Energy/Fire


var lastH : int
var lastE : int
var lastW : int

@onready var animPlr: AnimationPlayer = $AnimationPlayer


func update() -> void:
	if lastH != player.health:
		health.text = "Health: "  + str(player.health)
		lastH = player.health
		animPlr.play("health up")
	if lastE != player.energy:
		energy.text = "Energy: "  + str(player.energy)
		lastE = player.energy
	if lastW != enemies.wave:
		wave.text = "Wave: "  + str(enemies.wave)
		lastW = enemies.wave
		animPlr.play("wave up")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update()
	#updFire()
	
	
func updFire():
	var val = (100 - player.health)/100
	
	fire.material.set_shader_parameter("strength", 2.6 + (.4 * val))
	fire.material.set_shader_parameter("height", -.7 + (.9 * val))
	#."shader_parameter/strength" = 3
