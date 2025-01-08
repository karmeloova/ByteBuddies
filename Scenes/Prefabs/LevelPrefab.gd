extends Node2D
@export var exp_bar : TextureProgressBar
@export var level : Label
@export var exp : Label
@export var pop_up_node : Node2D
@export var text_level : Label
@onready var next_level_pop_up = preload("res://Scenes/Prefabs/UI/NextLevelPopUp.tscn")
var next_level_instance

func _ready():
	check_promotion()
	set_level_elements()
	LevelManager.changed_exp.connect(_on_changed_exp)
	LevelManager.promoted.connect(_on_promoted)
	SignalManager.show_next_pop_up.connect(_on_show_next_pop_up)

func set_level_elements() :
	exp_bar.value = LevelManager.exp
	level.text = "Poziom " + str(LevelManager.current_level.level)
	exp.text = str(LevelManager.exp) + "/" + str(LevelManager.current_level.next_level_need_exp)
	exp_bar.max_value = LevelManager.current_level.next_level_need_exp
	text_level.text = str(LevelManager.current_level.level)

func _on_changed_exp() :
	exp_bar.value = LevelManager.exp
	exp.text = str(LevelManager.exp) + "/" + str(LevelManager.current_level.next_level_need_exp)

func check_promotion() :
	set_level_elements()
	
	for i in LevelManager.was_promotion.size() :
		next_level_instance = next_level_pop_up.instantiate()
		pop_up_node.add_child(next_level_instance)
		next_level_instance.set_textes(LevelManager.promoted_levels[i])
		if(i==0) : next_level_instance.visible = true
		else : next_level_instance.visible = false
	LevelManager.was_promotion.clear()
	LevelManager.promoted_levels.clear()

func _on_show_next_pop_up() :
	pop_up_node.get_child(0).queue_free()
	if(pop_up_node.get_children().size() >= 2) : pop_up_node.get_child(1).visible = true

func _on_promoted() :
	check_promotion()
