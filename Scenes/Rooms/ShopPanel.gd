extends Node2D

@export var shops_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_button_pressed(arg):
	$Buttons.visible = false
	$"../PanelTemplate/Exit".visible = false
	$Back.visible = true
	shops_node.get_child(arg).visible = true

func _on_back_button_pressed():
	for i in shops_node.get_children() :
		i.visible = false
	$Buttons.visible = true
	$"../PanelTemplate/Exit".visible = true
	$Back.visible = false

func _on_back_button_mouse_entered():
	$Back.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$Back.modulate = Color("ffffff")

func _on_visibility_changed():
	if(!visible) :
		$Buttons.visible = true
		for i in $Shops.get_children() :
			i.visible = false
		$Back.visible = false
	
