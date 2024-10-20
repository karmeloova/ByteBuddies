extends Node2D

var can_fall = false
@export var can_move = false
var grounded = false
@export var height : int
var fixing = false
var was_collision = false
@export var can_rotate : bool
@export var how_many_rotate : int;
@export var floor_collision : Area2D
@export var block_collision : Area2D
var left_wall = false;
var right_wall = false;
var key_pressed
@export var scalee : Array[Vector2]
@export var move_tab : Array[int]
var move_block = 0

func _ready():
	global_position.x = 587

func _process(delta):
	if(can_move and !grounded) :
		position.y += 200*delta

func _input(event): 
	if(Input.is_key_pressed(KEY_SPACE)) :
		can_move = true;
	
	if(can_move and !grounded) :
		if(Input.is_key_pressed(KEY_RIGHT) and !right_wall) :
			position.x += 45
			print("DDDD")
		if(Input.is_key_pressed(KEY_LEFT) and !left_wall) :
			position.x -= 45
			print("AAAA")
		
	if(Input.is_key_pressed(KEY_W) and can_rotate and !grounded) :
		match how_many_rotate :
			2:
				if(rotation_degrees == 0) : 
					set_correctly("90", scalee[0])
					rotation_degrees = 90
				else : 
					set_correctly("00", scalee[1])
					rotation_degrees = 0
			4:
				if(rotation_degrees == 270) : rotation_degrees = 0
				else : rotation_degrees += 90

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

func _on_block_collision_area_entered(area):
	var curr_bloc = area.get_node("../..")
	if(area.name.contains("Floor") and !curr_bloc.was_collision) :
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

func set_correctly(deg : String, myscale : Vector2) :
	scale = myscale
	for shape in floor_collision.get_children() :
		if(shape.name.contains(deg)) : shape.disabled = false;
		else : shape.disabled = true;
	
	for shape in block_collision.get_children() :
		if(shape.name.contains(deg)) : shape.disabled = false;
		else : shape.disabled = true;
