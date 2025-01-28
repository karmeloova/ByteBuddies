extends Node2D

func _on_back_button_pressed():
	$"../../MainNode".visible = true
	$"..".visible = false
	SignalManager.set_console_text.emit("")
	get_parent().get_parent().back_button.visible = true

func _on_back_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	modulate = Color("ffffff")
