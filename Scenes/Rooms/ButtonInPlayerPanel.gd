extends Node2D
@export var node_to_hide : Node2D
@export var node_to_show : Node2D
@export var exit_button : Node2D
@export var back_button : Node2D

func _on_button_pressed():
	SignalManager.set_panel_to_hide.emit(node_to_show)
	node_to_hide.visible = false
	node_to_show.visible = true
	exit_button.visible = false
	back_button.visible = true

func _on_button_mouse_entered():
	modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	modulate = Color("ffffff")
