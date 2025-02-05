extends Node
@export var guide_node : Node2D

func _on_button_pressed(extra_arg_0):
	$".".visible = false
	guide_node.visible = true
	for guide in guide_node.get_children() :
		if(guide.name == extra_arg_0 || guide.name == "Back") : guide.visible = true
		else : guide.visible = false
	get_parent().back_button.visible = false


func _on_tutorial_button_pressed():
	VariableManager.tutorial = true
	for child in get_parent().panels.get_children() :
		if(child.name != "NextLevelsPopUp") : child.visible = false
	
	get_parent().tutorial_node.show_tutorial()
