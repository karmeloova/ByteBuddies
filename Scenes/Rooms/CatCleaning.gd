extends Node2D
var is_mouse_moving = false
var stop_timer = 0.0
var bubble_sprite 

func _process(delta):
	if VariableManager.is_mouse_moving:
		stop_timer -= delta
		if stop_timer <= 0 :
			VariableManager.is_mouse_moving = false

func _on_cat_area_entered(area):
	if(area.name == "Soap") : 
		VariableManager.is_soap_on_cat = true
		SignalManager.cleaning.emit(true)

func _on_cat_area_exited(area):
	if(area.name == "Soap") : 
		VariableManager.is_soap_on_cat = false
		SignalManager.cleaning.emit(false)

func _on_back_button_mouse_entered():
	$"../Back".modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$"../Back".modulate = Color("ffffff")

func _on_back_button_pressed():
	$"..".visible = false;
	$"../../Room".visible = true;
	
func _input(event):
	if event is InputEventMouseMotion:
		VariableManager.is_mouse_moving = true
		stop_timer = 0.05 
