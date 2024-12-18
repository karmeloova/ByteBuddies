extends Node2D

func _on_back_button_mouse_entered():
	$Back.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$Back.modulate = Color("ffffff")

func _on_back_button_pressed():
	$".".visible = false;
	$"../Room".visible = true;
