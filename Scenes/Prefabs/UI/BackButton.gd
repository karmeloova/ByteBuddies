extends Node2D

func _on_back_button_mouse_entered():
	modulate = Color("b2b2b2")


func _on_back_button_mouse_exited():
	modulate = Color("ffffff")


func _on_back_button_pressed():
	if($"../HowToPlay".visible == true) :
		$"../Panel".visible = true
		$"../HowToPlay".visible = false
	else :
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn")
