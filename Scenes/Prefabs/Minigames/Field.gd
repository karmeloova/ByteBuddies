extends Control
@export var have_data : bool = false
@export var instruction : Label
@export var instruction_texture : TextureRect
@export var drawn : bool = false
@export var start_field : TextureRect
@export var is_good : bool = false

var pos = Vector2(0,0)
@export var dragged_object : Control
var instruction_text

func _ready():
	SignalManager.check_field.connect(_on_check_field)

func _can_drop_data(at_position, data):
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

func _on_check_field() :
	if(instruction_text == instruction.text) :
		instruction_texture.modulate = Color("96ffa1")
		dragged_object.draggable = false
		is_good = true
	else :
		instruction_texture.modulate = Color("b6274b")
		dragged_object.apparent_move()
		is_good = false

func _on_child_exiting_tree(node):
	have_data = false
	SignalManager.removed_data_from_field.emit(instruction_text)

func drawned() :
	_drop_data(pos, dragged_object)
