extends Area2D
var added_to_bowl : bool = false
@export var fridge : Control
@export var panel_template : Node2D

func _ready():
	fridge.visible = false;

func _on_mouse_entered():
	$Miska.modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	$Miska.modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) : 
		panel_template.visible = true
		fridge.visible = true;
