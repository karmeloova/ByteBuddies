extends Node2D
var start_position;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position;
	
	SignalManager.go_forward.connect(_on_go_forward);
	SignalManager.go_right.connect(_on_go_right);
	SignalManager.go_left.connect(_on_go_left);
	SignalManager.restart_button.connect(_on_restart_button_)

func _on_go_forward(steps) :
	position.y = position.y - 94*steps;
	print("I go ", steps, " steps forward");
	
func _on_go_right(steps) :
	position.x = position.x + 94*steps;
	print("I go ", steps, " steps right");
	
func _on_go_left(steps) :
	position.x = position.x - 94*steps;
	print("I go ", steps, " steps left");

func _on_restart_button_():
	position = start_position;
