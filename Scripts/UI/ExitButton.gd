extends Node2D
@export var panels_node : Node2D
@export var buttons_node : Node2D

func _on_button_pressed():
	for i in panels_node.get_children() :
		if i.visible == true :
			i.visible = false
	
	for i in buttons_node.get_children() :
		if(i.has_node("Button")) :
			i.get_node("Button").disabled = false
		else :
			if(i.has_node("Collision")) :
				i.get_node("Collision").disabled = false

func _on_button_mouse_entered():
	$Button.modulate = Color("b2b2b2")
	$Icon.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$Button.modulate = Color("ffffff")
	$Icon.modulate = Color("ffffff")
