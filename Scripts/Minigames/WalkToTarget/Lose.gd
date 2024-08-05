extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	SignalManager.loseGame.connect(_on_lose_game)

func _on_lose_game() :
	visible = true;
	$LoseLabel.text = "Przegrałeś"
	
func _on_restart_button_pressed():
	SignalManager.restartGame.emit()
	visible = false;

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainRoom.tscn")
