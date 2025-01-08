extends TextureButton

func _on_mouse_entered():
	modulate = Color("b2b2b2")

func _on_mouse_exited():
	modulate = Color("ffffff")

func _on_pressed():
	SignalManager.reoder_child.emit()
	VariableManager.is_playing = true
	if(VariableManager.needs["play"] < 80) :
		Needs.can_count_to_achievement = true
	else :
		Needs.can_count_to_achievement = false
	get_tree().paused = false
	$"../..".visible = false
