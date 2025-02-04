extends Node2D

func _on_back_button_pressed():
	$"../MainNode".visible = true
	$"../AudioSettings".visible = false
	$"../GraphicsSettings".visible = false
	visible = false
	#process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().exit_button.visible = true

func _on_back_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	modulate = Color("ffffff")
