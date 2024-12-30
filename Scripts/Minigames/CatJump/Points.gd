extends Label
var points : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_point.connect(_on_add_point)
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.restartGame.connect(_on_save_data)
	SignalManager.save_data.connect(_on_save_data)
	text = "Score: " + str(0)

func _on_add_point() :
	points += 1
	text = "Score: " + str(points)

func _on_lose_game() :
	if(points > VariableManager.cat_jump_high_score) :
		VariableManager.cat_jump_high_score = points
	SignalManager.add_exp.emit(points/2)
	SignalManager.unlock_achievement.emit(points, "cat_jump", $"..")

func _on_save_data() :
	SignalManager.add_exp.emit(points/2)
