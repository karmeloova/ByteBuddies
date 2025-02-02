extends OptionButton
var pop_up : Array
var arrow_up = load("res://Images/Backgrounds/ArrowUp.png")
var arrow_down = load("res://Images/Backgrounds/ArrowDown.png")

func _ready():
	await get_tree().physics_frame
	pop_up = get_children(true)
	pop_up[0].get_viewport().transparent_bg = true

func _on_pressed():
	if(pop_up[0].visible) :
		add_theme_icon_override("arrow", arrow_up)
	else :
		add_theme_icon_override("arrow", arrow_down)
