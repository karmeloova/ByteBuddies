extends Node2D
@export var audio_panel : Control
@export var graphics_panel : Control
@export var main_panel : Node2D
@export var exit_button : Node2D
@export var back_button : Node2D

func _on_graphics_pressed():
	graphics_panel.visible = true
	main_panel.visible = false
	back_button.visible = true
	exit_button.visible = false

func _on_audio_pressed():
	audio_panel.visible = true
	main_panel.visible = false
	back_button.visible = true
	exit_button.visible = false
