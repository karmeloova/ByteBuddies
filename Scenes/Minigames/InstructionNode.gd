extends Node2D
@export var tasks : Array[Code_Task]
var random_task : Code_Task
var tab : Array[String] = []
var instruction_node = self
var Instruction = preload("res://Scenes/Prefabs/Minigames/DragAndDropPrefab.tscn")
var instruction_instance;
var random_instruction 

var instruction_tab : Array
var field_tab : Array
var start_field_tab : Array
var instruction_pos = Vector2(30,30)
var field_pos = Vector2(30,150)

var field
var instruction

var make_enter : bool = false
var remove_tab : bool = false
var is_first : bool = true
var tab_size : int = 100
@export var all_field_has_data : bool = false

func _ready():
	set_level()
	SignalManager.added_data_to_field.connect(_on_added_data) 
	SignalManager.nextLevel.connect(_on_next_level)
	$"../Label".text = random_task.description
	
func _on_added_data(text) :
	all_field_has_data = true
	for i in instruction_node.get_children() :
		if !i.get_node("Field").have_data :
			all_field_has_data = false
			break

func set_elements_pos(instruction_instance, is_first : bool) :
	instruction = instruction_instance.get_node("Control")
	field = instruction_instance.get_node("Field")
	
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

func set_instructions_pos() :
	random_instruction = field_tab.pick_random()
	random_instruction.get_node("Control").draggable = false
	random_instruction.get_node("Field").drawned()
	random_instruction.get_node("StartField").visible = false
	
	for i in range(instruction_tab.size()) :
		if(random_instruction == field_tab[i]) :
			instruction_tab.remove_at(i)
			field_tab.remove_at(i)
			start_field_tab.remove_at(i)
			break;
	
	field_tab.shuffle()

	for i in range(instruction_tab.size()) :
		field_tab[i].get_node("Control").position = instruction_pos
		field_tab[i].get_node("Control").start_pos = field_tab[i].get_node("Control").position
		field_tab[i].get_node("StartField").position = instruction_pos
		instruction_pos.x += 120
		
	for i in range(start_field_tab.size()) :
		start_field_tab[i].set_right_instruction_pos()

func _on_next_level() :
	if($".".get_child_count() > 0) :
		for i in self.get_children() :
			i.queue_free()
	
	instruction_tab = []
	field_tab = []
	start_field_tab = []
	instruction_pos = Vector2(30,30)
	field_pos = Vector2(30,150)
	is_first = true
	make_enter = false
	remove_tab = false
	all_field_has_data = false
	set_level()

func set_level() :
	random_task = tasks.pick_random()
	tab = random_task.instructions
	
	for i in range(tab.size()) :
		if(tab[i] != "enter") :
			instruction_instance = Instruction.instantiate()
			instruction_node.call_deferred("add_child", instruction_instance)
			instruction_instance.get_node("Control/Label").text = tab[i]
			instruction_tab.append(instruction_instance.get_node("Control"))
			field_tab.append(instruction_instance)
			start_field_tab.append(instruction_instance.get_node("StartField"))
			set_elements_pos(instruction_instance, is_first)
		else :
			make_enter = true
		is_first = false

	set_instructions_pos()
