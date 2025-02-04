extends Control
var code_element : CodeElement
var quantity = 0
var part_storage : storage_resource

func _ready():
	SignalManager.enable_use_buttons.connect(_on_enable_use_buttons)
	if(VariableManager.current_plan != null) :
		_on_enable_use_buttons(VariableManager.current_plan.needed_code_elements, VariableManager.plan_parts)

func set_code_element(element) :
	code_element = element
	quantity += 1
	$CodeElementName.text = code_element.code_element_name
	$QuantityLabel.text = str(quantity)
	
	part_storage = storage_resource.new()
	part_storage.item = code_element
	part_storage.amount = quantity
	VariableManager.parts_resource.append(part_storage)

func increase_element_quantity() :
	quantity += 1
	$QuantityLabel.text = str(quantity)
	change_amount_of_correct_part(1)

func _on_use_button_pressed():
	SignalManager.add_code_element_to_plan.emit(code_element)

func decrease_element_quantity() :
	quantity -= 1
	$QuantityLabel.text = str(quantity)
	change_amount_of_correct_part(-1)

func load_part_from_save(element : CodeElement, amount : int) :
	code_element = element
	quantity = amount
	$CodeElementName.text = code_element.code_element_name
	$QuantityLabel.text = str(quantity)

func change_amount_of_correct_part(number : int) :
	for part in VariableManager.parts_resource :
		if(part.item.res_name == code_element.res_name) :
			part.amount += number
			if(part.amount == 0) : 
				VariableManager.parts_resource.erase(part)
			return

func _on_enable_use_buttons(code_elements_tab : Array[CodeElement], ingridients_bool : Array) :
	if(code_elements_tab != null) :
		for i in code_elements_tab.size() :
			if(code_elements_tab[i].res_name == code_element.res_name && ingridients_bool[i] == false) :
				$UseButton.disabled = false
				return
		$UseButton.disabled = true
