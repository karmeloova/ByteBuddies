extends Node

@export var template : Node2D
@export var panel : Node2D
@export var panels_node : Node2D
@onready var buttons_panel = $".."

func _on_button_mouse_entered():
	if(not $Button.disabled && !get_tree().paused) :
		$Button.modulate = Color("b2b2b2")
		$Icon.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$Button.modulate = Color("ffffff")
	$Icon.modulate = Color("ffffff")

func _on_button_pressed():
	for p in panels_node.get_children() :
		if(p.name != "NextLevelsPopUp") :
			p.visible = false
	
	if(panel != null and template != null and name != "Exit") :
		template.visible = true
		panel.visible = true
		template.get_node("Exit").visible = true
		template.get_node("Back").visible = false
