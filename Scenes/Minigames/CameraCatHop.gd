extends Camera2D
var camera_speed : int = 125
var move = true
var start_position = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.restartGame.connect(_on_restart_game)
func _process(delta):
	if(VariableManager.moved and move) :
		position.y -= camera_speed*delta
	
func _on_lose_game() :
	move = false

func _on_restart_game() :
	position = start_position
	move = true
