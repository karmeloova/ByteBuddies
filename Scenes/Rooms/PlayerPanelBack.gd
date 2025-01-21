extends Node2D

var panel_to_hide : Node2D

func _ready():
	SignalManager.set_panel_to_hide.connect(_on_set_panel_to_hide)

func _on_back_button_pressed():
	panel_to_hide.visible = false
	visible = false
	$"../Exit".visible = true
	$"../../PlayerPanel".visible = true

func _on_back_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	modulate = Color("ffffff")

func _on_set_panel_to_hide(panel) :	
	panel_to_hide = panel
