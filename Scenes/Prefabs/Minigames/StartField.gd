extends Control
@export var have_data : bool = false
@export var instruction : Label
@export var instruction_texture : TextureRect
@export var drawn : bool = false
@export var back_to_pos : bool
var pos = Vector2(0,0)
@export var dragged_object : Control
var moved_object
var instruction_text
var tween : Tween

func _can_drop_data(_at_position, data):
	if not have_data : 
		return true
	else :
		return false

func _drop_data(at_position, data):
	data.get_parent().remove_child(data)
	add_child(data)
	data.position = Vector2(-2,-2)
	have_data = true
	instruction_text = data.get_node("Label").text
	SignalManager.added_data_to_field.emit(instruction_text)

func _on_child_exiting_tree(node):
	have_data = false
	SignalManager.removed_data_from_field.emit(instruction_text)

func set_right_instruction_pos() :
	_drop_data(Vector2(-2,-2), dragged_object)

