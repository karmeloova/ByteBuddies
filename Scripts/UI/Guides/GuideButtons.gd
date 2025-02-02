extends Node
@export var guide_node : Node2D

func _on_button_pressed(extra_arg_0):
	$".".visible = false
	guide_node.visible = true
	for guide in guide_node.get_children() :
		if(guide.name == extra_arg_0 || guide.name == "Back") : guide.visible = true
		else : guide.visible = false
	get_parent().back_button.visible = false
