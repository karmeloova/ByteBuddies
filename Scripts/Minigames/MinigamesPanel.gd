extends Node2D

func _ready():
	visible = false;

func _on_walk_to_target_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/WalkToTarget.tscn");

func _on_cat_hop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/CatHop.tscn");

func _on_drag_and_drop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/DragAndDrop.tscn");

func _on_logic_tetris_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Minigames/LogicTetris.tscn");
