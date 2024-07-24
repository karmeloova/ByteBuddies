extends Area2D

func _ready():
	$"../Fridge".visible = false;

func _on_mouse_entered():
	$Miska.modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	$Miska.modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) : 
		$"../Fridge".visible = true;
		
func _on_back_button_pressed():
	$"../Fridge".visible = false;
