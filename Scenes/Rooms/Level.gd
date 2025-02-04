extends Area2D
@export var panel_template : Node2D
@export var level : Node2D
@export var panels_node : Node2D

func _on_mouse_entered():
	if(!get_tree().paused) :
		modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !get_tree().paused) : 
		for p in panels_node.get_children() :
			if(p.name != "NextLevelsPopUp") :
				p.visible = false
	
		if(level != null and panel_template != null and name != "Exit") :
			panel_template.visible = true
			level.visible = true
			panel_template.get_node("Exit").visible = true
			panel_template.get_node("Back").visible = false
