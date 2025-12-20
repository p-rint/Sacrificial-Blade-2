extends CanvasLayer 

var visualCards

var T1 = ["T1", 1]
var T2 = ["T2", 2]
var T3 = ["T3", 3]
var T4 = ["T4", 4]
var T5 = ["T5", 5]
var T6 = ["T6", 6]

var cardTypes = [T1, T2, T3, T4, T5, T6]

var cardSet = [1, 2, 3] #the set of cards 

func button1() -> void:
	print("Button1")

func button2() -> void:
	print("Button2")

func button3() -> void:
	print("Button3")

func setCard() -> void:
	
	
	for i in visualCards.size():
		var randomCardType = randi_range(0, cardTypes.size() - 1)
		cardSet[i] = randomCardType
		#cards[i] = randi_range(0, types.size() - 1) ]
	
	showCards()
	

func showCards() -> void:
	
	for i in visualCards.size():
		var curCard = cardSet[i]
		
		visualCards[i].text = cardTypes[ curCard ] [0] #0 = Name,  1 = function
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visualCards = get_children()
	#Setup cards 1st
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("CardTest"):
		setCard()
	pass
