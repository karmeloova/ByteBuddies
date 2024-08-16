extends Control

var food_list : Array[Food_Resource]
var is_in_array : bool = false

var Food = preload("res://Scenes/FridgePosition.tscn")
var food_instance
@onready var food_node = get_node("ScrollContainer/VBoxContainer")
var first : bool = true
var first_pos = Vector2(210, 110)
var last_pos = Vector2.ZERO
@onready var box_min_size = $ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_to_fridge.connect(_on_add_to_fridge)

func _on_add_to_fridge(item) :
	is_in_array = false
	for i in range(food_list.size()) :
		if(item.food_name == food_list[i].food_name) : 
			is_in_array = true
			break
				
	if not is_in_array :
		food_list.append(item)
		update_fridge(item, false, item.food_name)
	else :
		update_fridge(item, true, item.food_name)

func update_fridge(item : Food_Resource, is_in_the_fridge : bool, food : String) :
	if not is_in_the_fridge :
		food_instance = Food.instantiate()
		food_node.call_deferred("add_child", food_instance)
		food_instance.get_node("Amount").text = str(item.amount)
		food_instance.get_node("Name").text = item.food_name
		food_instance.get_node("HungryPoints").text = "+" + str(item.hungry_points) + "%"
		box_min_size.custom_minimum_size.y += 150
		
	else :
		for i in food_node.get_children() :
			if(i.get_node("Name").text == food) :
				i.get_node("Amount").text = str(item.amount)
	
