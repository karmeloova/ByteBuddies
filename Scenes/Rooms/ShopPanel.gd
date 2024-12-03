extends Node2D

var Item = preload("res://Scenes/ItemScene.tscn")
var item_instance

@onready var food_node = get_node("Foods")

@export var _food_resources: Array[Food_Resource]
var food_shop_positions : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.check_buy_possibilities.connect(check_buy_possibilities)
	visible = false
	food_shop()

func _on_food_button_pressed():
	$Food.visible = false
	$"../PanelTemplate/Exit".visible = false
	$Foods.visible = true
	check_buy_possibilities()
	
func food_shop() :
	for i in range(_food_resources.size()) :
		VariableManager.food_item = _food_resources[i]
		item_instance = Item.instantiate()
		food_node.add_child(item_instance)
		item_instance.position = Vector2(-320, -130+80*i)
		item_instance.get_node("Price").text = str(_food_resources[i].price)
		item_instance.get_node("HungryPoints").text = "+" + str(_food_resources[i].hungry_points) + "%"
		#item_instance.get_node("Image").texture = _food_resources[i].image
		item_instance.get_node("Name").text = str(_food_resources[i].food_name)
		food_shop_positions.append(item_instance)

func check_buy_possibilities() :
	for i in range(_food_resources.size()) :
		if(_food_resources[i].price > VariableManager.coins) :
			food_shop_positions[i].get_node("Buy").disabled = true
		else:
			food_shop_positions[i].get_node("Buy").disabled = false

func _on_back_button_pressed():
	$Foods.visible = false
	$Food.visible = true
	$"../PanelTemplate/Exit".visible = true
