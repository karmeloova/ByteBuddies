extends Area2D

func _on_mouse_entered():
	$Sprite.modulate = Color("b2b2b2")


func _on_mouse_exited():
	$Sprite.modulate = Color("ffffff")


func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) :
		get_tree().change_scene_to_file("res://Scenes/ScratchingPost.tscn");
