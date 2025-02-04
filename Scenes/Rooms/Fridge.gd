extends Control

var food_list : Array[Food_Resource]
var is_in_array : bool = false
var added_to_bowl : bool = false

@export var panel : Node2D

var Food = preload("res://Scenes/FridgePosition.tscn")
var food_instance
@onready var food_node = get_node("ScrollContainer/VBoxContainer")
var first : bool = true
var first_pos = Vector2(210, 110)
var last_pos = Vector2.ZERO
@onready var box_min_size = $ScrollContainer/VBoxContainer

func _ready():
	SignalManager.add_to_fridge.connect(_on_add_to_fridge)
	SignalManager.add_to_bowl.connect(_on_add_to_bowl)
	SignalManager.remove_from_fridge.connect(_on_remove_from_fridge)
	SignalManager.changed_needs.connect(_on_needs_changed)
	$HungryInformation/HowManyCatNeeds.text = "Kotek potrzebuje: " + str(100-VariableManager.needs["hungry"])+"%"
	$HungryInformation/HowManyInBowl.text = "Obecnie w misce: " + str(VariableManager.hungry_points_in_bowl)+"%"
	load_food_resources()
	
func _on_add_to_fridge(item : Food_Resource) :
	for food_in_storage in food_node.get_children() :
		if(food_in_storage.food.food_name == item.food_name) :
			food_in_storage.increase_food_count()
			return
	
	food_instance = Food.instantiate()
	food_instance.add_to_frigde_ui(item)
	food_node.call_deferred("add_child", food_instance)
	
func _on_feed_mouse_entered():
	$Feed.modulate = Color("b2b2b2")

func _on_feed_mouse_exited():
	$Feed.modulate = Color("ffffff")

func _on_feed_pressed():
	if added_to_bowl && $ScrollContainer.visible == true:
		visible = false
		panel.visible = false
		added_to_bowl = false
		if(VariableManager.needs["hungry"] < 80) :
			# Czas animacji podejścia kota do miski (może taka będzie)
			SignalManager.go_to_bowl.emit();
		$"..".visible = false;
		$"../../Room".visible = true
	if($ScrollContainer.visible == false && $"../CodeFeedNode".visible == true) :
		SignalManager.code_feed.emit()

func _on_add_to_bowl(hungry_points) :
	VariableManager.hungry_points_in_bowl += hungry_points.to_int()
	$HungryInformation/HowManyInBowl.text = "Obecnie w misce: " + str(VariableManager.hungry_points_in_bowl)+"%"
	if not added_to_bowl :
		# Oznacza to, że dodaliśmy do miski cokolwiek
		added_to_bowl = true

func _on_remove_from_fridge(item) :
	for food_in_storage in food_node.get_children() :
		if(food_in_storage.food.food_name == item.food_name) :
			food_in_storage.queue_free()
			return
			
func load_food_resources() :
	for food in VariableManager.food_resource:
		food_instance = Food.instantiate()
		food_instance.load_food_resources(food.item, food.amount)
		food_node.call_deferred("add_child", food_instance)

func _on_needs_changed() :
	$HungryInformation/HowManyCatNeeds.text = "Kotek potrzebuje: " + str(100-VariableManager.needs["hungry"]) + "%"
