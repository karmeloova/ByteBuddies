extends Label
var points : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_point.connect(_on_add_point)
	text = "Wynik: " + str(0)

func _on_add_point() :
	points += 1
	text = "Wynik: " + str(points)
