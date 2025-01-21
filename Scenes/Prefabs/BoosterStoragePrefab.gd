extends Control
var plan_quantity = 0
var current_plan

func set_plan_ui(plan : Plan) :
	current_plan = plan
	$PlanName.text = plan.plan_name
	plan_quantity += 1
	$QuantityLabel.text = str(plan_quantity)

func increase_plan_quantity() :
	plan_quantity += 1
	$QuantityLabel.text = str(plan_quantity)


func _on_use_button_pressed():
	SignalManager.set_current_booster.emit(current_plan)
