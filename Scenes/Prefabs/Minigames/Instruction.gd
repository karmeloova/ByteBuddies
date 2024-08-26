extends Control
var draggable : bool = true
var start_pos = Vector2.ZERO
var is_mouse : bool = false
var instruction_font_size

func _ready():
	instruction_font_size = $Label.get_theme_font_size("font_size")

func _get_drag_data(at_position):
	var drag_data = Control.new()
	var texture_rect = TextureRect.new()
	texture_rect.texture = $Instruction.texture
	texture_rect.size = $Instruction.size
	drag_data.add_child(texture_rect)
	var label = Label.new()
	label.text = $Label.text
	label.size = $Label.size
	label.add_theme_font_size_override("font_size", instruction_font_size)
	label.vertical_alignment = $Label.vertical_alignment
	label.horizontal_alignment = $Label.horizontal_alignment
	drag_data.add_child(label)
	set_drag_preview(drag_data)
	return self
