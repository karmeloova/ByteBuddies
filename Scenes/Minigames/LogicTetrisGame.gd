extends Node2D

@export var blocks : Array[PackedScene]
#var Block = preload("res://Scenes/Prefabs/Minigames/LogicTetrisPrefab.tscn")
var block_instance;
@onready var block_node = get_node("Blocks")
var pos_tab : Array;
var line = false;
var line_to_remove : Array
var move_down = false;
var tween;

func _ready():
	SignalManager.new_blok_needed.connect(_on_new_block_needed)
	_generate_block()
	
	for i in range(12) :
		pos_tab.append([])
		for j in range(10) :
			pos_tab[i].append(null)
 
func _generate_block() :
	if(!move_down) :
		block_instance = blocks.pick_random().instantiate()
		block_node.call_deferred("add_child", block_instance)
		block_instance.position.x = 340

func _on_new_block_needed(current_x_pos, current_y_pos) :
	if(!move_down) :
		#print(current_x_pos, " + ", current_y_pos)
		#pos_tab[int(current_y_pos/45-2)][int(current_x_pos/45)] = block_instance
		_check_line()
		_generate_block()

func _check_line() :
	for i in range(12) :
		line = true;
		for j in range(10) :
			if(!pos_tab[i][j]) : 
				line = false;
				break
		if(line) :
			line_to_remove = pos_tab[i]
			_remove_line()
			_move_down()
			break;

func _remove_line() :
	for child in block_node.get_children() :
		for j in range(line_to_remove.size()) :
			if(child == line_to_remove[j]) :
				child.queue_free()
				line_to_remove[j] = null
	
	pos_tab.remove_at(pos_tab.size()-1);
	pos_tab.push_front([null, null, null, null, null, null, null, null, null, null])

func _move_down() :
	move_down = true;
	for i in range(12) :
		for j in range(10) :
			if(pos_tab[i][j]) : 
				pos_tab[i][j].get_node("Block").position.y += 45;
	$"../Timer".start(0.05)
	
func _on_timer_timeout():
	move_down = false;
	_generate_block()


func _on_walls_area_exited(area):
	area.get_node("../..").left_wall = false

func _on_wall_right_area_exited(area):
	area.get_node("../..").right_wall = false
