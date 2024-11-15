extends Area2D
var added_to_bowl : bool = false
@export var fridge : Control
@export var panel_template : Node2D

func _ready():
	fridge.visible = false;
	SignalManager.go_to_bowl.connect(_on_go_to_bowl)
	SignalManager.eat_end.connect(_on_eat_end)

func _on_mouse_entered():
	if(panel_template.visible == false) : modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && panel_template.visible == false) : 
		panel_template.visible = true
		fridge.visible = true;

func _on_go_to_bowl() :
	$Food.visible = true;

func _on_eat_end() :
	$Food.visible = false
