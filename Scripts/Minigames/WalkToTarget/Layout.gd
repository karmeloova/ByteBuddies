extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause/PauseMenu.visible = false;

func _on_pause_button_pressed():
	SignalManager.stopGame.emit();
	$Pause/PauseMenu.visible = !$Pause/PauseMenu.visible;

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn");

func _input(event):
	if(Input.is_key_pressed(KEY_ESCAPE)) :
		$Pause/PauseMenu.visible = !$Pause/PauseMenu.visible;


func _on_back_button_pressed():
	$Pause/PauseMenu.visible = !$Pause/PauseMenu.visible;
	SignalManager.startGameAfterPause.emit();


func _on_restart_button_pressed():
	$Pause/PauseMenu.visible = !$Pause/PauseMenu.visible;
	SignalManager.restartGame.emit();
