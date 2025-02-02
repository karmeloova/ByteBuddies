extends Node2D
@export var achievements_node : Node2D

func _on_back_button_pressed():
	$"../../PanelTemplate/Back".visible = true
	visible = false
	$"../AchievementsButtons".visible = true
	for i in achievements_node.get_children() :
		if(i.visible == true) : i.visible = false
	
