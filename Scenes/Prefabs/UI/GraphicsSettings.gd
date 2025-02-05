extends Control
@export var resolution_dropdown : OptionButton
@export var full_screen_check_box : CheckBox
var current_resolution
var fullhd_pos
var is_full_screen

var resolutions = {
	"1920x1080" : Vector2i(1920, 1080),
	"1366x768" : Vector2i(1366, 768),
	"1280x720" : Vector2i(1280, 720),
	"1440x900" : Vector2i(1440, 900),
	"1600x900" : Vector2i(1600, 900),
	"1152x648" : Vector2i(1152, 648),
	"1024x600" : Vector2i(1024, 600),
	"800x600" : Vector2i(800, 600)
}

func _ready():
	for i in resolutions :
		resolution_dropdown.add_item(i)
	SignalManager.save_settings.connect(_on_save_settings)
	full_screen_check_box.button_pressed = VariableManager.is_full_screen
	resolution_dropdown.selected = VariableManager.resolution
	current_resolution = resolution_dropdown.selected

func _on_resolution_drop_down_item_selected(index):
	current_resolution = index
	var key = resolution_dropdown.get_item_text(current_resolution)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().set_size(resolutions[key])
	var window_size = DisplayServer.window_get_size()
	var screen_index = DisplayServer.window_get_current_screen()
	var screen_rect = DisplayServer.screen_get_usable_rect(screen_index) 
	var new_position = screen_rect.position + (screen_rect.size - window_size) / 2
	# Set the new position
	DisplayServer.window_set_position(new_position)
	#get_window().set_position(screen_center - window_size/2)

func _on_check_box_toggled(toggled_on):
	if(!toggled_on) :
		resolution_dropdown.disabled = false
		_on_resolution_drop_down_item_selected(current_resolution)
		fullhd_pos = DisplayServer.window_get_position()
	else :
		resolution_dropdown.disabled = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	is_full_screen = toggled_on
	
func _on_save_settings(saving : bool):
	if(saving) :
		VariableManager.resolution = resolution_dropdown.selected
		VariableManager.is_full_screen = full_screen_check_box.button_pressed
	else :
		full_screen_check_box.button_pressed = VariableManager.is_full_screen
		resolution_dropdown.selected = VariableManager.resolution
