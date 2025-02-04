extends Area2D
var start_position;
var can_be_pick
var bubble_scene = load("res://Scenes/Prefabs/Bubble.tscn")
@export var bubble_node : Node2D
var bubble_instance
var is_deleting_bubbles = false

func _ready():
	start_position = position;

func _process(delta):
	if(can_be_pick && Input.is_action_pressed("move_item")) :
		position = get_global_mouse_position()
		if(VariableManager.is_soap_on_cat && VariableManager.is_mouse_moving) : generate_bubble(position)
	if(Input.is_action_just_released("move_item")) :
		position = start_position

func _on_mouse_entered():
	can_be_pick = true;

func _on_mouse_exited():
	can_be_pick = false;

func generate_bubble(pos : Vector2) :
	bubble_instance = bubble_scene.instantiate()
	var random_scale = randf_range(0.5, 1.2)
	bubble_instance.scale = Vector2(random_scale, random_scale)
	bubble_instance.position = Vector2(pos.x - 50, pos.y - 40)
	bubble_node.add_child(bubble_instance)
	if(!is_deleting_bubbles && bubble_node.get_child_count() > 20) : 
		delete_bubbles()
		is_deleting_bubbles = true

func delete_bubbles() :
	while bubble_node.get_child_count() > 0:
		bubble_node.get_child(0).queue_free()
		await get_tree().create_timer(0.0068).timeout
	is_deleting_bubbles = false

func _input(event):
	if(Input.is_action_just_released("move_item")) :
		is_deleting_bubbles = false
