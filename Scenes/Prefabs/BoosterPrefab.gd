extends Node2D
@export var plan : Plan

func _ready():
	set_plan_ui()

func set_plan_ui() :
	$PlanName.text = plan.plan_name
	if(LevelManager.current_level.level >= plan.required_level.level) :
		$Price.visible = true
		$RequiredLevel.visible = false
	else :
		$RequiredLevel/ReqLevelLabel.text = "Poziom " + str(plan.required_level.level)
		$RequiredLevel.visible = true
		$Price.visible = false


func _on_buy_button_pressed():
	SignalManager.add_plan_booster.emit(plan)
