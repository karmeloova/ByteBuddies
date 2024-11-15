extends Area2D
@export var panel_template : Node2D
@export var level : Node2D

func _on_mouse_entered():
	if(panel_template.visible == false) :
		modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && panel_template.visible == false) : 
		panel_template.visible = true
		level.visible = true
