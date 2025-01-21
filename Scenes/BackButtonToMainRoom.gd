extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn")

func _on_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	modulate = Color("ffffff")
