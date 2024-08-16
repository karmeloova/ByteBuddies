extends Area2D
var added_to_bowl : bool = false

func _ready():
	$"../Fridge".visible = false;
	SignalManager.add_to_bowl.connect(_on_add_to_bowl)

func _on_mouse_entered():
	$Miska.modulate = Color("b2b2b2");
	
func _on_mouse_exited():
	$Miska.modulate = Color("ffffff");

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) : 
		$"../Fridge".visible = true;
		
func _on_back_button_pressed():
	$"../Fridge".visible = false;
	# W momencie gdy zamykamy panel miski, oznacza to, że skończyliśmy ją
	# napełniać
	if added_to_bowl :
		added_to_bowl = false
		if(VariableManager.needs["hungry"] < 50) :
			# Czas animacji podejścia kota do miski (może taka będzie)
			$AnimTimer.start(5)

func _on_add_to_bowl(hungry_points) :
	VariableManager.hungry_points_in_bowl += hungry_points.to_int()
	if not added_to_bowl :
		# Oznacza to, że dodaliśmy do miski cokolwiek
		added_to_bowl = true
	
func _on_anim_timer_timeout():
	SignalManager.eat.emit()
