extends Control
var code_element : CodeElement
var quantity = 0

func set_code_element(element) :
	code_element = element
	quantity += 1
	$CodeElementName.text = code_element.code_element_name
	$QuantityLabel.text = str(quantity)

func increase_element_quantity() :
	quantity += 1
	$QuantityLabel.text = str(quantity)

func _on_use_button_pressed():
	SignalManager.add_code_element_to_plan.emit(code_element)

func decrease_element_quantity() :
	quantity -= 1
	$QuantityLabel.text = str(quantity)
