extends Control
@export var code_element : CodeElement

func _ready():
	set_code_element_ui()

func set_code_element_ui():
	$CodeElementName.text = code_element.code_element_name
	$PriceLabel.text = str(code_element.price)

func _on_buy_button_pressed():
	SignalManager.add_code_element.emit(code_element);
