extends Node

@export var template : Node2D
@export var panel : Node2D
@onready var buttons_panel = $".."

func _on_button_mouse_entered():
	if(not $Button.disabled) :
		$Button.modulate = Color("b2b2b2")
		$Icon.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$Button.modulate = Color("ffffff")
	$Icon.modulate = Color("ffffff")

func _on_button_pressed():
	if(panel != null and template != null and name != "Exit") :
		template.visible = !template.visible
		panel.visible = !panel.visible
		change_disable_another_buttons()

func change_disable_another_buttons():
	for i in buttons_panel.get_children() :
		if(i.has_node("Button")) :
			i.get_node("Button").disabled = true
		else :
			if(i.has_node("Collision")) :
				i.get_node("Collision").disabled = true
			else :
				print("no i chuj no i dupa ani to ani to")
