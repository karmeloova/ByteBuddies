extends Node2D

func _on_cat_area_entered(area):
	if(area.name == "Soap") : SignalManager.cleaning.emit(true)

func _on_cat_area_exited(area):
	if(area.name == "Soap") : SignalManager.cleaning.emit(false)

func _on_back_button_mouse_entered():
	$"../Back".modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$"../Back".modulate = Color("ffffff")

func _on_back_button_pressed():
	$"..".visible = false;
	$"../../Room".visible = true;
