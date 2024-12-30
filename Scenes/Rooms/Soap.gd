extends Area2D
var start_position;
var can_be_pick

func _ready():
	start_position = position;

func _process(delta):
	if(can_be_pick && Input.is_action_pressed("move_item")) :
		position = get_global_mouse_position()
	if(can_be_pick && Input.is_action_just_released("move_item")) :
		position = start_position

func _on_mouse_entered():
	can_be_pick = true;

func _on_mouse_exited():
	can_be_pick = false;


	
