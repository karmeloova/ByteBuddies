extends Node2D

var plan_instance
var plan_storage_prefab = load("res://Scenes/Prefabs/BoosterStoragePrefab.tscn")
@onready var plan_node = $ScrollContainer/PlansStorage

func _ready():
	SignalManager.add_plan_booster.connect(_on_add_plan_booster)

func _on_add_plan_booster(plan : Plan) :
	if(plan_node.get_child_count() > 0) :
		for i in plan_node.get_children() :
			if(plan == i.current_plan) : 
				i.increase_plan_quantity()
				return
	
	plan_instance = plan_storage_prefab.instantiate()
	plan_instance.set_plan_ui(plan)
	plan_node.add_child(plan_instance)
