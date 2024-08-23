extends Control

var food : Food_Resource

func _ready():
	food = VariableManager.food_item
	
func _on_add_to_bowl_pressed():
	SignalManager.add_to_bowl.emit($HungryPoints.text)
	SignalManager.remove_from_fridge.emit(food)
