extends Node2D

func _on_information_button_mouse_entered():
	$InformationButton.modulate = Color("b2b2b2")
	$Icon.modulate = Color("b2b2b2")
	$InformationNode.visible = true


func _on_information_button_mouse_exited():
	$InformationButton.modulate = Color("ffffff")
	$Icon.modulate = Color("ffffff")
	$InformationNode.visible = false
