extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;


func _on_walk_to_target_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/WalkToTarget.tscn");


func _on_cat_hop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/CatHop.tscn");
