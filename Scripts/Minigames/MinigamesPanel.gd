extends Node2D

func _ready():
	visible = false;

func _on_walk_to_target_button_pressed():
	if(check_if_play_possible()) :
		get_tree().change_scene_to_file("res://Scenes/Minigames/WalkToTarget.tscn");

func _on_cat_hop_button_pressed():
	if(check_if_play_possible()) :
		get_tree().change_scene_to_file("res://Scenes/Minigames/CatHop.tscn");

func _on_drag_and_drop_button_pressed():
	if(check_if_play_possible()) :
		get_tree().change_scene_to_file("res://Scenes/Minigames/DragAndDrop.tscn");

func _on_fruit_catcher_button_pressed():
	if(check_if_play_possible()) :
		get_tree().change_scene_to_file("res://Scenes/Minigames/FruitCatcher.tscn");

func check_if_play_possible() -> bool:
	if(VariableManager.needs["hungry"] > 30 && VariableManager.needs["sleep"] > 30) :
		return true
	else : 
		$WarningLabel.visible = true
		return false

func _on_visibility_changed():
	$WarningLabel.visible = false
