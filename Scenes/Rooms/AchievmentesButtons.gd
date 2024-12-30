extends Node2D

@export var achievmentes_nodes : Node2D

func _on_button_pressed(ind) :
	$".".visible = false
	$"../Back".visible = true
	$"../../PanelTemplate/Exit".visible = false
	find_achievmentes(ind)

func find_achievmentes(ind) :
	var i : int = 0
	for ach in achievmentes_nodes.get_children() :
		if(i==ind) : 
			ach.visible = true
			break;
		i += 1
