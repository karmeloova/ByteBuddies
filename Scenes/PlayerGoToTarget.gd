extends Node2D
var start_position;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	position =VariableManager.start_position
	print(position)

	SignalManager.go_forward.connect(_on_go_forward);
	SignalManager.go_right.connect(_on_go_right);
	SignalManager.go_left.connect(_on_go_left);
	SignalManager.restart_button.connect(_on_restart_button_)
	SignalManager.set_player_pos.connect(_on_set_player_pos)

func _on_go_forward(steps) :
	position.y = position.y - VariableManager.tile_size.y*steps;
	print("I go ", steps, " steps forward");
	print(position)
	
func _on_go_right(steps) :
	position.x = position.x + VariableManager.tile_size.x*steps;
	print("I go ", steps, " steps right");
	
func _on_go_left(steps) :
	position.x = position.x - VariableManager.tile_size.x*steps;
	print("I go ", steps, " steps left");

func _on_restart_button_():
	position = start_position;

func _on_set_player_pos(first_pos) :
	print("AA")
