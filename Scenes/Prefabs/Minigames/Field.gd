extends Control
@export var have_data : bool = false
@export var instruction : Label
@export var instruction_texture : TextureRect
@export var drawn : bool = false
@export var start_field : TextureRect
@export var is_good : bool = false
var index : int
var is_next_level : bool = false

var pos = Vector2(0,0)
@export var dragged_object : Control
var moved_object
var instruction_text
var instruction_index

func _ready():
	SignalManager.check_field.connect(_on_check_field)

func _can_drop_data(_at_position, _data):
	if not have_data : 
		return true
	else :
		return false

func _drop_data(_at_position, data):
	data.get_parent().remove_child(data)
	add_child(data)
	data.position = Vector2(-2,-2)
	have_data = true
	moved_object = data
	instruction_text = data.get_node("Label").text
	SignalManager.added_data_to_field.emit(instruction_text)

func _on_check_field():
	if instruction_text == instruction.text:
		moved_object.get_node("Instruction").modulate = Color("96ffa1")
		moved_object.draggable = false
		is_good = true
	else:
		moved_object.get_node("Instruction").modulate = Color("b6274b")
		moved_object.apparent_move()
		SignalManager.bad_field.emit()
		is_good = false

func _on_child_exiting_tree(_node):
	have_data = false
	SignalManager.removed_data_from_field.emit(instruction_text)

func drawned() :
	_drop_data(pos, dragged_object)
