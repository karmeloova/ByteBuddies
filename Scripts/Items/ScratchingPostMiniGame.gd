extends Area2D
var mouse_button = 1;

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouse_button == 1) :
		print("DRAP1")
		SignalManager.scratch.emit(5);
		mouse_button = 0;
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) && mouse_button == 0) :
		print("DRAP2")
		SignalManager.scratch.emit(5);
		mouse_button = 1;


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Rooms/MainRoom.tscn");
