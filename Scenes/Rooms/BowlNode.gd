extends Node2D
@export var panels_node : Node2D

func _on_back_button_mouse_entered():
	$Back.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$Back.modulate = Color("ffffff")

func _on_back_button_pressed():
	$".".visible = false;
	$"../Room".visible = true;
	for p in panels_node.get_children() :
		if(p.name != "NextLevelsPopUp") :
			p.visible = false


func _on_code_feed_pressed():
	$CodeFeedNode.visible = false
	$NormalFeed/ScrollContainer.visible = true

func _on_code_feed_mouse_entered():
	$NormalFeedButton.modulate = Color("b2b2b2")

func _on_code_feed_mouse_exited():
	$NormalFeedButton.modulate = Color("ffffff")
