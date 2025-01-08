extends TextureButton

func _on_mouse_entered():
	modulate = Color("b2b2b2")

func _on_mouse_exited():
	modulate = Color("ffffff")

func _on_pressed():
	$"../../HowToPlay".visible = true
	$"..".visible = false
