extends Area2D
var added_to_bowl : bool = false
@export var fridge : Control
@export var panel_template : Node2D
@export var panels_node : Node2D

func _ready():
	if(VariableManager.hungry_points_in_bowl > 0) :
		$Bowl/Food.visible = true;
	else :
		$Bowl/Food.visible = false;
	fridge.visible = false;
	SignalManager.eat_end.connect(_on_eat_end)
	SignalManager.add_to_bowl.connect(_on_add_to_bowl)

func _on_mouse_entered():
	$Bowl.modulate = Color("b2b2b2");
	$Label.text = "Obecnie: \n" + str(VariableManager.hungry_points_in_bowl) + "%"
	$Label.visible = true
	
func _on_mouse_exited():
	$Bowl.modulate = Color("ffffff");
	$Label.visible = false

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) : 
		panel_template.visible = true
		fridge.visible = true;
		$"../../..".visible = false;
		for p in panels_node.get_children() :
			if(p.name != "NextLevelsPopUp") :
				p.visible = false

func _on_eat_end() :
	if(VariableManager.hungry_points_in_bowl > 0) :
		$Bowl/Food.visible = true;
	else :
		$Bowl/Food.visible = false;

func _on_add_to_bowl(text : String) :
	$Bowl/Food.visible = true;
