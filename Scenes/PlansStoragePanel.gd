extends Node2D

var plan_instance
var plan_storage_prefab = load("res://Scenes/Prefabs/BoosterStoragePrefab.tscn")
@onready var plan_node = $ScrollContainer/PlansStorage

func _ready():
	SignalManager.add_plan_booster.connect(_on_add_plan_booster)
	SignalManager.decrease_plan_counter.connect(_on_decrease_plan_counter)
	set_plans_from_save()
	if(BoosterManager.active_booster != null) :
		$ActiveBoosterInformation.visible = true
	else :
		$ActiveBoosterInformation.visible = false

func _on_add_plan_booster(plan : Plan) :
	if(plan_node.get_child_count() > 0) :
		for i in plan_node.get_children() :
			if(plan.res_name == i.current_plan.res_name) : 
				i.increase_plan_quantity()
				return
	
	plan_instance = plan_storage_prefab.instantiate()
	plan_instance.set_plan_ui(plan)
	plan_node.add_child(plan_instance)

func _on_decrease_plan_counter(plan : Plan) :
	if(plan_node.get_child_count() > 0) :
		for i in plan_node.get_children() :
			if(plan.res_name == i.current_plan.res_name) : 
				i.decrease_plan_quantity()
				if(i.plan_quantity == 0) : i.queue_free()
				return

func set_plans_from_save():
	for plans in VariableManager.plans_resource :
		plan_instance = plan_storage_prefab.instantiate()
		plan_instance.load_plans_from_save(plans.item, plans.amount)
		plan_node.add_child(plan_instance)
