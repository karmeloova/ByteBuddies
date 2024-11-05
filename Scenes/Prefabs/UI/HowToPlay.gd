extends Node2D
var instruction : Node2D
var pages : Array[RichTextLabel]
var is_next = true
var is_previous = true
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.set_correct_instruction.connect(_set_correct_instruction)

func _on_next_button_mouse_entered():
	$Next.modulate = Color("b2b2b2")

func _on_next_button_mouse_exited():
	$Next.modulate = Color("ffffff")

func _on_next_button_pressed():
	is_next = true
	for i in range(0, pages.size()) :
		if(pages[i].visible == true) :
			pages[i+1].visible = true
			pages[i].visible = false
			$Previous.visible = true;
			if(i+1 == pages.size() - 1) : is_next = false
			break;
		
	if(!is_next) : 
		$Next.visible = false

func _set_correct_instruction(game_name) :
	match game_name :
		"Snack Navigator" :
			$SnackNavigator.visible = true
			instruction = $SnackNavigator
		"Cat Jump" :
			$CatJump.visible = true
			instruction= $CatJump
		"Pet Code" :
			$CodePet.visible = true
			instruction = $CodePet
	set_pages()

func set_pages() :
	for i in instruction.get_children() :
		pages.append(i)
	pages[0].visible = true
	for i in range(1,pages.size()) :
		pages[i].visible = false
	
	if(pages.size() <= 1) : $Next.visible = false

func _on_back_button_pressed():
	is_previous = true
	for i in range(0, pages.size()) :
		if(pages[i].visible == true) :
			pages[i-1].visible = true
			pages[i].visible = false
			$Next.visible = true
			if(!(i-1 > 0)) : 
				is_previous = false
			break;
		
	if(!is_previous) : 
		$Previous.visible = false
		$Next.visible = true

func _on_back_button_mouse_entered():
	$Previous.modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$Previous.modulate = Color("ffffff")

