extends Area2D
@export var panel_template : Node2D
@export var panels_node : Node2D

func _on_mouse_entered():
	$Sprite.modulate = Color("b2b2b2")

func _on_mouse_exited():
	$Sprite.modulate = Color("ffffff")

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) :
		$"..".visible = false
		$"../../ScratchingPost".visible = true
		if(VariableManager.needs["scratch"] < 80) :
			Needs.can_count_to_achievement = true
		else :
			Needs.can_count_to_achievement = false
		
		for p in panels_node.get_children() :
			if(p.name != "NextLevelsPopUp") :
				p.visible = false
		
