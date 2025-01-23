extends Control
@export var code_element : CodeElement

func _ready():
	SignalManager.update_fish_counter.connect(_on_update_fish_counter)
	set_code_element_ui()
	can_be_buy()

func set_code_element_ui():
	$CodeElementName.text = code_element.code_element_name
	$PriceLabel.text = str(code_element.price)

func _on_buy_button_pressed():
	SignalManager.add_code_element.emit(code_element);
	VariableManager.fishes -= code_element.price
	SignalManager.update_fish_counter.emit()

func _on_button_mouse_entered():
	SignalManager.show_description.emit(code_element.code_element_description)

func _on_button_mouse_exited():
	SignalManager.hide_description.emit()

func _on_update_fish_counter():
	can_be_buy()
	
func can_be_buy() :
	if(VariableManager.fishes < code_element.price) :
		$BuyButton.disabled = true
	else :
		$BuyButton.disabled = false
