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
		VariableManager.food_item = item
		food_node.call_deferred("add_child", food_instance)
		food_instance.get_node("Amount").text = str(item.amount)
		food_instance.get_node("Name").text = item.food_name
		food_instance.get_node("HungryPoints").text = "+" + str(item.hungry_points) + "%"
		box_min_size.custom_minimum_size.y += 150
		
	else :
		for i in food_node.get_children() :
			if(i.get_node("Name").text == food) :
				i.get_node("Amount").text = str(item.amount)
	
func _on_feed_mouse_entered():
	$Feed.modulate = Color("b2b2b2")

func _on_feed_mouse_exited():
	$Feed.modulate = Color("ffffff")

func _on_feed_pressed():
	if added_to_bowl :
		visible = false
		panel.visible = false
		added_to_bowl = false
		if(VariableManager.needs["hungry"] < 50) :
			# Czas animacji podejścia kota do miski (może taka będzie)
			SignalManager.go_to_bowl.emit();

func _on_add_to_bowl(hungry_points) :
	VariableManager.hungry_points_in_bowl += hungry_points.to_int()
	if not added_to_bowl :
		# Oznacza to, że dodaliśmy do miski cokolwiek
		added_to_bowl = true

func _on_remove_from_fridge(item) :
	item.amount -= 1
	for i in food_node.get_children() :
		if(i.get_node("Name").text == item.food_name) :
			if(item.amount == 0) :
				i.queue_free()
				for j in range(food_list.size()) :
					if(food_list[j] == item) :
						print(food_list[j].food_name, " ", j)
						food_list.remove_at(j)
						box_min_size.custom_minimum_size.y -= 150
						break
			else :
				i.get_node("Amount").text = str(item.amount)
