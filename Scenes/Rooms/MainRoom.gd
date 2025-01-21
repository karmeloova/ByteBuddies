extends Node2D
var cat_name_instance
@onready var cat_name_scene = load("res://Scenes/Prefabs/UI/SetCatName.tscn")

func _ready():
	if(VariableManager.first_start) :
		set_cat_name()
		VariableManager.first_start = false
	VariableManager.is_playing = false

func set_cat_name():
	cat_name_instance = cat_name_scene.instantiate()
	self.add_child(cat_name_instance)
	get_tree().paused = true
