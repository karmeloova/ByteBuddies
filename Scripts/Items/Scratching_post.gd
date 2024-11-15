extends Area2D
@export var panel_template : Node2D

func _on_mouse_entered():
	if(panel_template.visible == false) :
		$Sprite.modulate = Color("b2b2b2")

func _on_mouse_exited():
	$Sprite.modulate = Color("ffffff")

func _on_input_event(viewport, event, shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && panel_template.visible == false) :
		$"..".visible = false
		$"../../ScratchingPost".visible = true
