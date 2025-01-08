extends Node2D
@export var panel_template : Node2D
@export var panel_to_show : Node2D

func _on_area_2d_mouse_entered():
	if(panel_template.visible == false) :
		$BathObject.modulate = Color("b2b2b2")

func _on_area_2d_mouse_exited():
	$BathObject.modulate = Color("ffffff")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && panel_template.visible == false) :
		panel_to_show.visible = true;
		$"..".visible = false;

