extends Control
var win : bool = true
var current_field

func _on_texture_button_mouse_entered():
	if not $TextureButton.disabled :
		modulate = Color("b2b2b2")

func _on_texture_button_mouse_exited():
	modulate = Color("ffffff")

func _on_texture_button_pressed():
	if($"../InstructionNode".all_field_has_data) :
		for i in $"../InstructionNode".get_children() :
			SignalManager.check_field.emit()
		win_or_lose()

func win_or_lose() :
	var instructions = $"../InstructionNode"
	win = true
	for ins in instructions.get_children() :
		if(!ins.get_node("Field").is_good) : win = false
	
	if(win) : 
		SignalManager.nextLevel.emit()
	else : 
		SignalManager.loseLife.emit()

func check_field(field) :
	field.get_node("Field").check_field()
