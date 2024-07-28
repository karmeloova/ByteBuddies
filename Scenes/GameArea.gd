extends Node2D
var match_instructions = ["forward", "left", "right"];
var instruction = "";
var tab_of_instructions = [];

var user_code;
var user_code_length;

var tile = preload("res://Scenes/Tiles.tscn");
@onready var world = get_node("/root/WalkToTarget/GameArea")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalManager.code_to_make.connect(_on_code_to_make);
	SignalManager.restart_button.connect(_on_restart_button)
	
	SignalManager.moveEnd.connect(_on_end_move)
	
func _on_code_to_make():
	user_code = VariableManager.code;
	user_code_length = VariableManager.code.length();
	
	if(user_code[user_code_length-1] != "\n") : 
		user_code = user_code + "\n";
		user_code_length = user_code.length();
		
	for i in range(user_code_length) :
		if(user_code[i] != "\n") : instruction = instruction + user_code[i];
		else : 
			tab_of_instructions.append(instruction);
			instruction = "";
	tab_of_instructions.append("end");
	make_move();

func make_move() :
	var steps;
	for i in range(tab_of_instructions.size()) :
		steps = tab_of_instructions[i].to_int()
		if(tab_of_instructions[i].contains("forward")) : 
			SignalManager.go_forward.emit(steps);
		if(tab_of_instructions[i].contains("left")) : 
			SignalManager.go_left.emit(steps);
		if(tab_of_instructions[i].contains("right")) : 
			SignalManager.go_right.emit(steps);
		if(tab_of_instructions[i].contains("end")) :
			SignalManager.end_code.emit();
		
func _on_restart_button() :
	tab_of_instructions = [];

func _on_end_move() :
	tab_of_instructions = [];
	instruction = "";
