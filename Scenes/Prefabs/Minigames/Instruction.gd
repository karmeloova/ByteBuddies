extends Control
@export var draggable : bool = true
@export var start_pos = Vector2.ZERO
var is_mouse : bool = false
var instruction_font_size
var tween : Tween
@export var start_field : TextureRect
@export var drop_data_timer : Timer

func _ready():
	instruction_font_size = $Label.get_theme_font_size("font_size")

func _get_drag_data(at_position):
	if(draggable) :
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

func apparent_move() :
	print(start_pos)
	tween = self.create_tween()
	tween.tween_property(self, "global_position", Vector2(start_pos.x-2,start_pos.y-2), 2)
	drop_data_timer.start(2)

func _on_drop_data_timer_timeout():
	start_field.set_right_instruction_pos()
