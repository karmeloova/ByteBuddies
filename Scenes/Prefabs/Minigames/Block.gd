extends Node2D

var can_fall = false
@export var can_move = false
var grounded = false
var fixing = false
var was_collision = false
@export var can_rotate : bool
@export var how_many_rotate : int;
var left_wall = false;
var right_wall = false;
@export var scalee : Array[Vector2]
@export var move_tab : Array[int]
var move_block = 0
@export var blocks : Array[Sprite2D]
@export var edges_left : Area2D
@export var edges_right : Area2D
var edge_bool = false

func _ready():
	global_position.x = 587

func _input(event): 
	if(Input.is_key_pressed(KEY_SPACE)) :
		can_move = true;
		$MoveY.start(0.5)
	
	if(can_move and !grounded) :
		if(Input.is_key_pressed(KEY_RIGHT) and !right_wall) :
			position.x += 45
			print(position.x)
		if(Input.is_key_pressed(KEY_LEFT) and !left_wall) :
			position.x -= 45
			print(position.x)
		
	if(Input.is_key_pressed(KEY_W) and can_rotate and !grounded) :
		match how_many_rotate :
			2:
				if(rotation_degrees == 0) : 
					set_correctly("90", scalee[0], move_tab[0])
					rotation_degrees = 90
					cheeeck()
				else : 
					set_correctly("00", scalee[1], move_tab[1])
					rotation_degrees = 0
					cheeeck()
			4:
				if(rotation_degrees == 0) : 
					set_correctly("90", scalee[0], move_tab[0])
					rotation_degrees = 90
					cheeeck()
				elif(rotation_degrees == 90) : 
					set_correctly("180", scalee[1], move_tab[1])
					rotation_degrees = 180
					cheeeck()
				elif(rotation_degrees == 180) : 
					set_correctly("270", scalee[2], move_tab[2])
					rotation_degrees = 270
					cheeeck()
				else : 
					set_correctly("00", scalee[3], move_tab[3])
					rotation_degrees = 0
					cheeeck()

func _on_floor_collision_area_entered(area):
	if(area.name=="Floor") :
		$Elements.global_position.y = 648 + move_block
		can_move = false;
		grounded = true
		SignalManager.new_blok_needed.emit(position.x, position.y)
	if(area.name.contains("WallRight")) :
		right_wall = true
	if(area.name.contains("WallLeft")) :
		left_wall = true
	
	var curr_bloc = area.get_node("../..")
	if(area.name.contains("Block") and !curr_bloc.grounded) :
		curr_bloc.was_collision = true
		curr_bloc.can_move = false;
		curr_bloc.grounded = true
		curr_bloc.get_node("Elements").global_position.y = fix_pos(curr_bloc.get_node("Elements").global_position)
		SignalManager.new_blok_needed.emit(area.position.x, area.position.y)
	if(area.name.contains("WallRight")) :
		right_wall = true
	if(area.name.contains("WallLeft")) :
		left_wall = true

func fix_pos(curr_pos) -> int:
	fixing = true
	var how_many = 648-curr_pos.y
	var multiply = ceil(how_many/45)
	return 648-multiply*45

func set_correctly(deg : String, myscale : Vector2, move_y : int) :
	scale = myscale
	move_block = move_y
	for edge in edges_left.get_children() :
		if(edge.name.contains(deg)) :
			edge.disabled = false
		else : 
			edge.disabled = true
		
	for edge in edges_right.get_children() :
		if(edge.name.contains(deg)) :
			edge.disabled = false
		else : 
			edge.disabled = true

func _on_edges_left_area_entered(area):
	if(area.name.contains("Edges")) :
		area.get_node("../..").right_wall = true

func _on_edges_right_area_entered(area):
	if(area.name.contains("Edge")) :
		area.get_node("../..").left_wall = true;

func _on_edges_right_area_exited(area):
	if(area.name.contains("Edges")) :
		area.get_node("../..").left_wall = false

func _on_edges_left_area_exited(area):
	if(area.name.contains("Edge")) :
		area.get_node("../..").right_wall = false

func _on_move_y_timeout():
	if(can_move and !grounded) :
		position.y += 45
		$MoveY.start(0.5)
	else : $MoveY.stop()

func cheeeck() :
	for i in blocks.size() :
		print(blocks[i].global_position.x)
		if(blocks[i].global_position.x < 362) :
			print("AB")
			position.x = 362
		elif(blocks[i].position.x > 812) :
			print("DEEEFGGG")
			position.x = 812
