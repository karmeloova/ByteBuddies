extends Node2D
var food_type : Food_Resource = null

func _ready():
	# Dzięki temu dana instancja wie jakim jest przedmiotem, co umożliwi dodanie jej
	# do ekwpiunku
	food_type = VariableManager.food_item

func _on_buy_pressed():
	VariableManager.coins -= food_type.price
	SignalManager.change_money.emit()
	food_type.amount += 1
	SignalManager.add_to_fridge.emit(food_type)
