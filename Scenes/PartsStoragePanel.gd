extends Node2D
@onready var parts_node = $ScrollContainer/PartsStorage
var code_element_instance
var code_element_scene = load("res://Scenes/Prefabs/CodeElementStoragePrefab.tscn")

func _ready():
	SignalManager.add_code_element.connect(_on_add_code_element)
	SignalManager.decrease_code_element_counter.connect(_on_decrease_code_element_counter)

func _on_add_code_element(code_element) :
	if(parts_node.get_child_count() > 0) :
		for child in parts_node.get_children() :
			if(child.code_element == code_element) :
				child.increase_element_quantity()
				return
	
	code_element_instance = code_element_scene.instantiate()
	code_element_instance.set_code_element(code_element)
	parts_node.add_child(code_element_instance)

func _on_decrease_code_element_counter(code_element) :
	if(parts_node.get_child_count() > 0) :
		for child in parts_node.get_children() :
			if(child.code_element == code_element) :
				child.decrease_element_quantity()
				if(child.quantity == 0) : child.queue_free()
				return
