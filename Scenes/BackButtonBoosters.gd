extends Node2D
var panel_to_show
@export var panel_container : Node2D

func _ready():
	SignalManager.set_panel_to_show.connect(_on_set_panel_to_show)

func _on_button_pressed():
	for child in panel_container.get_children() :
		if(child==panel_to_show || child.name == "PanelTemplate") : child.visible = true
		else : child.visible = false
		
	$"../CloseButton".visible = true
	visible = false

func _on_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	modulate = Color("ffffff")

func _on_set_panel_to_show(panel) :
	panel_to_show = panel
