extends Control
var plan_quantity = 0
var current_plan
var booster_storage : storage_resource

func _ready():
	SignalManager.set_current_booster.connect(_on_set_current_booster)
	if(VariableManager.current_plan != null) :
		$UseButton.disabled = true
	check_active_boosters()

func set_plan_ui(plan : Plan) :
	current_plan = plan
	$PlanName.text = plan.plan_name
	plan_quantity += 1
	$QuantityLabel.text = str(plan_quantity)
	
	booster_storage = storage_resource.new()
	booster_storage.item = plan
	booster_storage.amount = plan_quantity
	VariableManager.plans_resource.append(booster_storage)

func increase_plan_quantity() :
	plan_quantity += 1
	$QuantityLabel.text = str(plan_quantity)
	change_amount_of_correct_plan(1)

func _on_use_button_pressed():
	SignalManager.set_current_booster.emit(current_plan)

func decrease_plan_quantity() :
	plan_quantity -= 1
	$QuantityLabel.text = str(plan_quantity)
	change_amount_of_correct_plan(-1)

func change_amount_of_correct_plan(number : int) :
	for plans in VariableManager.plans_resource :
		if(plans.item.res_name == current_plan.res_name) :
			plans.amount += number
			if(plans.amount == 0) : 
				VariableManager.plans_resource.erase(plans)
			return

func load_plans_from_save(plan : Plan, amount : int) :
	current_plan = plan
	$PlanName.text = plan.plan_name
	plan_quantity = amount
	$QuantityLabel.text = str(plan_quantity)

func _on_set_current_booster(plan : Plan) :
	$UseButton.disabled = true

func check_active_boosters() :
	if(BoosterManager.active_booster != null) :
		$UseButton.disabled = true
	else :
		$UseButton.disabled = false
