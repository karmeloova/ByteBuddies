extends Node2D
var lives = 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	$LivesLabel.text = "Życia: " + str(lives);
	
	SignalManager.loseLife.connect(_on_lose_life)

func _on_lose_life() :
	lives -= 1;
	$LivesLabel.text = "Życia: " + str(lives);
	if(lives == 0) : SignalManager.loseGame.emit();
