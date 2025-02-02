extends Node2D
var booster_text : String


func _on_button_mouse_entered():
	$PauseButton.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$PauseButton.modulate = Color("ffffff")

func _on_button_pressed():
	get_tree().paused = true
	$PauseMenu.visible = true
	check_active_booster()

func _on_back_button_pressed():
	get_tree().paused = false
	$PauseMenu/BoosterGamesLeft.visible = false
	$PauseMenu.visible = false

func _on_back_button_mouse_entered():
	$PauseMenu/BackButton.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$PauseMenu/BackButton.modulate = Color("ffffff")

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	SignalManager.restartGame.emit()
	VariableManager.is_playing = false

func _on_restart_button_mouse_entered():
	$PauseMenu/RestartButton.modulate = Color("b2b2b2")

func _on_restart_button_mouse_exited():
	$PauseMenu/RestartButton.modulate = Color("ffffff")

func _on_quit_button_pressed():
	SignalManager.save_data.emit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn")
	VariableManager.is_playing = false
	Achievements.test_playing_game(null)

func _on_quit_button_mouse_entered():
	$PauseMenu/QuitButton.modulate = Color("b2b2b2")

func _on_quit_button_mouse_exited():
	$PauseMenu/QuitButton.modulate = Color("ffffff")

func check_active_booster() :
	if(BoosterManager.active_booster != null && !$PauseMenu/BoosterGamesLeft.visible) :
		booster_text = "Booster " + BoosterManager.active_booster.plan_name + " aktywny. Pozostalo " + str(BoosterManager.games_duration) + " gier (wliczajac te)."
		$PauseMenu/BoosterGamesLeft.text = booster_text
		$PauseMenu/BoosterGamesLeft.visible = true

func _input(event):
	if(Input.is_key_pressed(KEY_ESCAPE)) :
		$PauseMenu.visible = !$PauseMenu.visible
		get_tree().paused = !get_tree().paused
		check_active_booster()
