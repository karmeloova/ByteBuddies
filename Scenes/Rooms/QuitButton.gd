extends Node2D

@export var exit_pop_up : Node2D

func _on_button_pressed():
	exit_pop_up.visible = true

func _on_mouse_entered() :
	modulate = Color("b2b2b2")

func _on_mouse_exited() :
	modulate = Color("ffffff")

func _on_yes_button_pressed():
	SaveManager._notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_no_button_pressed():
	exit_pop_up.visible = false
