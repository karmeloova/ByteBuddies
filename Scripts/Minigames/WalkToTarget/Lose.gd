extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.set_lose_score.connect(_on_set_lose_score)

func _on_lose_game() :
	VariableManager.is_playing = false;
	get_tree().paused = true
	visible = true;
	
func _on_restart_button_pressed():
	VariableManager.is_playing = true;
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_back_button_pressed():
	VariableManager.is_playing = false;
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn")

func _on_back_button_mouse_entered():
	$Back.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$Back.modulate = Color("ffffff")

func _on_restart_button_mouse_entered():
	$RestartButton.modulate = Color("b2b2b2")

func _on_restart_button_mouse_exited():
	$RestartButton.modulate = Color("ffffff")

func _on_set_lose_score(points : int, is_new_highscore : bool) :
	$PointsLabel.text = "Wynik: " + str(points)
	if(is_new_highscore) : $NewRecord.visible = true
	else : $NewRecord.visible = false
