extends Control
@export var food_type : Food_Resource 
@export var food_name : Label
@export var food_price : Label
@export var food_hungry_points : Label
@export var buy_button : Button

func _ready():
	SignalManager.change_money.connect(_on_change_money)
	set_item_scene()
	can_buy()
	
func _on_buy_pressed():
	VariableManager.coins -= food_type.price
	SignalManager.change_money.emit()
	SignalManager.add_to_fridge.emit(food_type)
	release_focus()

func set_item_scene() :
	food_price.text = str(food_type.price)
	food_hungry_points.text = "+" + str(food_type.hungry_points) + "%"
	food_name.text = food_type.food_name

func can_buy() :
	if(food_type.price > VariableManager.coins) :
		buy_button.disabled = true
		$MainContent/PriceBuyButton/Buy/Label.modulate = Color("c7c7c7")
	else:
		buy_button.disabled = false
		$MainContent/PriceBuyButton/Buy/Label.modulate = Color("ffffff")
		
func _on_change_money() :
	can_buy()
