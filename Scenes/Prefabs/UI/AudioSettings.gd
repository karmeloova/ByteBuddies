extends Control
@export var sliders_tab : Array[Slider]
@export var check_box_tab : Array[CheckBox]
var music_volumes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.play_music.emit(load("res://Audio/BackgroundMusic.mp3"))
	SignalManager.save_settings.connect(_on_save_settings)
	for i in range(3) :
		sliders_tab[i].value = VariableManager.volumes_levels[i]
		check_box_tab[i].button_pressed = VariableManager.mute_check_boxes[i]
		_on_check_box_toggled(check_box_tab[i].button_pressed, i)

func _on_slider_mouse_exited():
	release_focus()

func _on_slider_value_changed(value, extra_arg_0):
	AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(value))
	if(check_box_tab[extra_arg_0].button_pressed) :
		check_box_tab[extra_arg_0].button_pressed = false

func _on_check_box_toggled(toggled_on, extra_arg_0):
	if(toggled_on) : 
		AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(0))
	else : 
		AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(sliders_tab[extra_arg_0].value))
		
	VariableManager.mute_check_boxes[extra_arg_0] = toggled_on

func _on_save_settings(saving : bool) :
	if(saving) :
		for i in range(3) :
			VariableManager.volumes_levels[i] = sliders_tab[i].value
			VariableManager.mute_check_boxes[i] = check_box_tab[i].button_pressed
	else :
		for i in range(3) :
			sliders_tab[i].value = VariableManager.volumes_levels[i]
			check_box_tab[i].button_pressed = VariableManager.mute_check_boxes[i]
		
