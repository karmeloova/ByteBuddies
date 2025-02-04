extends Node2D

@export var panel_to_show : Node2D
@export var panel_container : Node2D
@export var button_container : Node2D
@export var second_level_button : bool

var previous_panel

func _on_button_pressed():
	if(second_level_button) : 
		for child in panel_container.get_children() :
			if(child.visible == true && child.name != "PanelTemplate") : 
				previous_panel = child
	else :
		for child in panel_container.get_children() :
			if(child.name == "PanelTemplate" && child.visible == true) : 
				set_exit_button()
	
	for child in panel_container.get_children() :
		if(child.visible == true) : child.visible = false
	
	panel_container.get_child(0).visible = true
	panel_to_show.visible = true
	
	if(second_level_button) : set_back_button()

func _on_button_mouse_entered():
	if(!get_node("Button").disabled) :
		modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	if(!get_node("Button").disabled) :
		modulate = Color("ffffff")

func set_back_button():
	panel_container.get_child(0).get_child(5).visible = false
	panel_container.get_child(0).get_child(6).visible = true
	SignalManager.set_panel_to_show.emit(previous_panel)

func set_exit_button():
	panel_container.get_child(0).get_child(5).visible = true
	panel_container.get_child(0).get_child(6).visible = false
