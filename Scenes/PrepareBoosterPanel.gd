extends Node2D
var ingridients : String
var ingridients_bool : Array[bool]
var current_plan
var have_all_indrigients : bool

func _ready():
	SignalManager.set_current_booster.connect(_on_set_current_booster)
	SignalManager.add_code_element_to_plan.connect(_on_add_code_element_to_plan)

func _on_set_current_booster(plan : Plan) :
	if(current_plan == null) :
		$Panel/BoosterName.text = "Current Booster: " + plan.plan_name
		current_plan = plan
		
		for code_element in plan.needed_code_elements :
			ingridients += code_element.code_element_name + " 0/1\n"
			ingridients_bool.append(false)
		
		$Panel/Ingridients.text = ingridients
		SignalManager.decrease_plan_counter.emit(current_plan)
	else :
		print("JUZ JEST UZYTY BOOSTER")

func _on_button_pressed():
	$Panel.visible = false
	
func _on_curr_button_pressed():
	$Panel.visible = true

func _on_add_code_element_to_plan(element : CodeElement):
	for i in current_plan.needed_code_elements.size() :
		if(element == current_plan.needed_code_elements[i]) :
			ingridients_bool[i] = true
			SignalManager.decrease_code_element_counter.emit(element)
	update_code_element_list()
		
func update_code_element_list():
	have_all_indrigients = true
	ingridients = ""
	for i in current_plan.needed_code_elements.size() :
		ingridients += current_plan.needed_code_elements[i].code_element_name
		if(ingridients_bool[i]) : ingridients += " 1/1\n"
		else : ingridients += " 0/1\n"
	
	for i in ingridients_bool :
		if(!i) :
			have_all_indrigients = false
			break
	if(have_all_indrigients) : $Panel/StartMakeBooster.visible = true
	$Panel/Ingridients.text = ingridients

func _on_start_make_booster_pressed():
	$"../ShopPart".visible = false
	$".".visible = false
	SignalManager.start_build_booster.emit(current_plan)
