extends Area3D

@onready var hitboxes = $".." #all hitboxes

var reaction : Callable

var ID : int

var alreadyHit = []


var direction = Vector3(0,0,-1)

var time = 1.0

@onready var holder = get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = randi()
	$Lifetime.start(time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hasHit(area : Area3D) -> bool:
	for i in alreadyHit: # If  already hit table
		if i == area:
			return true

	#if not in already hit table
	alreadyHit.append(area)
	return false

func _on_area_entered(area: Area3D) -> void:
	if area.get_parent() == hitboxes: # Make sure it's not an other attack hitbox
		return
		
	if area.name == "Hurtbox"   and   not hasHit(area):
		
		if area.get_parent().name != "Player":
			var enemy = area.get_parent()
			reaction.call(enemy)
			print("hitenemy")


func _on_lifetime_timeout() -> void:
	queue_free()
