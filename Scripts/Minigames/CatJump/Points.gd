extends Label
var points : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_point.connect(_on_add_point)
	SignalManager.loseGame.connect(_on_lose_game)
	text = "Score: " + str(0)

func _on_add_point() :
	points += 1
	text = "Score: " + str(points)

func _on_lose_game() :
	SignalManager.add_exp.emit(points*0.25)
