extends Node2D


func _on_button_pressed():
	$"../MinigamesPanel".visible = !($"../MinigamesPanel".visible);
