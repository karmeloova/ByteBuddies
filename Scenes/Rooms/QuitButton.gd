extends Node2D

func _on_button_pressed():
	SaveManager._notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_mouse_entered() :
	modulate = Color("b2b2b2")

func _on_mouse_exited() :
	modulate = Color("ffffff")
