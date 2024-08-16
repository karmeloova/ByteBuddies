extends Node2D

var Item = preload("res://Scenes/ItemScene.tscn")
var item_instance

@onready var food_node = get_node("Foods")

@export var _food_resources: Array[Food_Resource]

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_food_button_pressed():
	$Food.visible = false
	$"../PanelTemplate/Exit".visible = false
	$Foods.visible = true
	food_shop()
	
func food_shop() :
	for i in range(_food_resources.size()) :
		VariableManager.food_item = _food_resources[i]
		item_instance = Item.instantiate()
		food_node.add_child(item_instance)
		item_instance.position = Vector2(-320, -130+80*i)
		item_instance.get_node("Price").text = str(_food_resources[i].price)
		if(_food_resources[i].price > VariableManager.coins) :
			item_instance.get_node("Buy").disabled = true
		item_instance.get_node("HungryPoints").text = "+" + str(_food_resources[i].hungry_points) + "%"
		#item_instance.get_node("Image").texture = _food_resources[i].image
		item_instance.get_node("Name").text = str(_food_resources[i].food_name)


func _on_back_button_pressed():
	$Foods.visible = false
	$Food.visible = true
	$"../PanelTemplate/Exit".visible = true
	for i in food_node.get_children() :
		if(i.name != "Back") : i.queue_free()
