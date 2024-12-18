extends Node2D
@export var panel_template : Node2D
var is_sleeping : bool = false

func _on_area_2d_mouse_entered():
	if(panel_template.visible == false) :
		$DenObject.modulate = Color("b2b2b2")

func _on_area_2d_mouse_exited():
	$DenObject.modulate = Color("ffffff")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && panel_template.visible == false) :
		is_sleeping = !is_sleeping
		change_sleep_state()

func change_sleep_state() :
	SignalManager.sleeping.emit(is_sleeping)
	if(is_sleeping) :
		$"../..".modulate = Color("6a6a6a")
	else :
		$"../..".modulate = Color("ffffff")
