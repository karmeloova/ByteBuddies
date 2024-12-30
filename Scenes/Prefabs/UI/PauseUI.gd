extends Node2D

func _on_button_mouse_entered():
	$PauseButton.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$PauseButton.modulate = Color("ffffff")

func _on_button_pressed():
	get_tree().paused = true
	$PauseMenu.visible = true

func _on_back_button_pressed():
	get_tree().paused = false
	$PauseMenu.visible = false

func _on_back_button_mouse_entered():
	$PauseMenu/BackButton.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$PauseMenu/BackButton.modulate = Color("ffffff")

func _on_restart_button_pressed():
	VariableManager.is_playing = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	SignalManager.restartGame.emit()

func _on_restart_button_mouse_entered():
	$PauseMenu/RestartButton.modulate = Color("b2b2b2")

func _on_restart_button_mouse_exited():
	$PauseMenu/RestartButton.modulate = Color("ffffff")

func _on_quit_button_pressed():
	VariableManager.is_playing = false
	SignalManager.save_data.emit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn")
	Achievements.test_playing_game(null)

func _on_quit_button_mouse_entered():
	$PauseMenu/QuitButton.modulate = Color("b2b2b2")

func _on_quit_button_mouse_exited():
	$PauseMenu/QuitButton.modulate = Color("ffffff")
