extends Node2D
@export var plan : Plan
var desc : String
var counter : int = 0

func _ready():
	set_plan_ui()

func set_plan_ui() :
	SignalManager.update_fish_counter.connect(_on_update_fish_counter)
	
	$PlanName.text = plan.plan_name
	if(LevelManager.current_level.level >= plan.required_level.level) :
		$Price.visible = true
		$Price/PriceLabel.text = str(plan.price)
		$RequiredLevel.visible = false
	else :
		$RequiredLevel/ReqLevelLabel.text = "Poziom " + str(plan.required_level.level)
		$RequiredLevel.visible = true
		$Price.visible = false
	
	desc = plan.booster_description
	
	for i in plan.needed_code_elements :
		if(!(counter==plan.needed_code_elements.size()-1)) :
			desc += i.code_element_name + ", "
		else :
			desc += i.code_element_name
		counter += 1
	
	can_be_buy()

func _on_buy_button_pressed():
	SignalManager.add_plan_booster.emit(plan)
	VariableManager.fishes -= plan.price
	SignalManager.update_fish_counter.emit()

func _on_area_2d_mouse_entered():
	SignalManager.show_description.emit(desc)

func _on_area_2d_mouse_exited():
	SignalManager.hide_description.emit()

func can_be_buy() :
	if(VariableManager.fishes < plan.price) :
		$Price/BuyButton.disabled = true
	else :
		$Price/BuyButton.disabled = false

func _on_update_fish_counter() :
	can_be_buy()

