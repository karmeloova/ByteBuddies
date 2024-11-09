extends Node2D
var mouse_button = 1;
var is_mouse_on_scratching_post : bool = false
var tween
var current_scratch = 0
@onready var scratch_node = $"../ScratchNode"

func _ready():
	add_scratch()
	$"../PlayerScratching/Resume".modulate = Color("77DD77")

func _process(delta):
	if(is_mouse_on_scratching_post) :
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && mouse_button == 1) :
			$"../PlayerScratching".position.y = lerp($"../PlayerScratching".position.y, get_global_mouse_position().y, 0.1)
			scratch_node.get_child(current_scratch).add_point(get_global_mouse_position())
		elif(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) && mouse_button == 0) :
			$"../PlayerScratching".position.y = lerp($"../PlayerScratching".position.y, get_global_mouse_position().y, 0.1)
			scratch_node.get_child(current_scratch).add_point(get_global_mouse_position())
			
	if($"../PlayerScratching".position.y >= 413) : back_to_start()

func _on_back_button_pressed():
	for i in scratch_node.get_children() :
		i.queue_free()
	current_scratch = 0
	mouse_button = 1
	add_scratch()
	$"../PlayerScratching/Resume".modulate = Color("77DD77")
	$"..".visible = false
	$"../../Room".visible = true

func _on_player_scratching_mouse_entered():
	is_mouse_on_scratching_post = true

func _on_player_scratching_mouse_exited():
	is_mouse_on_scratching_post = false

func back_to_start() :
	current_scratch += 1
	SignalManager.scratch.emit(10)
	add_scratch()
	$"../PlayerScratching".position.y = 29
	if(mouse_button == 1) :
		mouse_button = 0
		$"../PlayerScratching/Resume".modulate = Color("FF6961")
	else : 
		$"../PlayerScratching/Resume".modulate = Color("77DD77")
		mouse_button = 1

func add_scratch() :
	var line = Line2D.new()
	line.width = 2
	line.default_color = Color("6E6E6E")
	scratch_node.add_child(line)

func _on_back_button_mouse_entered():
	$"../Back".modulate = Color("b2b2b2")

func _on_back_button_mouse_exited():
	$"../Back".modulate = Color("ffffff")
