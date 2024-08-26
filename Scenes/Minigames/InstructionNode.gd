extends Node2D
var tab : Array[String] = ["for", "i", "in range", "10", "\n", "print",
						  "XD"]
var instruction_node = self
var Instruction = preload("res://Scenes/Prefabs/Minigames/DragAndDropPrefab.tscn")
var instruction_instance;

var instruction_pos = Vector2(30,30)
var field_pos = Vector2(30,204)

var field
var instruction

var make_enter : bool = false
var remove_tab : bool = false
var is_first : bool = true
var tab_size : int = 100
@export var all_field_has_data : bool = false

func _ready():
	for i in range(tab.size()) :
		if(tab[i] != "\n") :
			instruction_instance = Instruction.instantiate()
			instruction_node.call_deferred("add_child", instruction_instance)
			instruction_instance.get_node("Control/Label").text = tab[i]
			set_elements_pos(instruction_instance, is_first)
		else :
			make_enter = true
		is_first = false

	SignalManager.added_data_to_field.connect(_on_added_data) 
	
func _on_added_data(text) :
	all_field_has_data = true
	for i in instruction_node.get_children() :
		if !i.get_node("Field").have_data :
			all_field_has_data = false
			break

func set_elements_pos(instruction_instance, is_first : bool) :
	instruction = instruction_instance.get_node("Control")
	field = instruction_instance.get_node("Field")
	
	instruction.position = instruction_pos
	instruction_pos.x += 120
	
	if(is_first) :
		field.position = field_pos
	else :
		if(make_enter) :
			if(not remove_tab) :
				field_pos.x = tab_size
				field_pos.y += 50
				field.position = field_pos
				make_enter = false
				remove_tab = true
			else :
				remove_tab = false
				make_enter = false
				field_pos.x = 30
				field_pos.y += 50
				field.position = field_pos
		else : 
			field_pos.x += 120
			field.position = field_pos
