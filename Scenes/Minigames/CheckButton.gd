extends Control

func _on_texture_button_mouse_entered():
	if not $TextureButton.disabled :
		modulate = Color("b2b2b2")

func _on_texture_button_mouse_exited():
	modulate = Color("ffffff")

func _on_texture_button_pressed():
	if($"../InstructionNode".all_field_has_data) :
		SignalManager.check_field.emit()
	else :
		print("Nie wszystkie mają dane :c")
