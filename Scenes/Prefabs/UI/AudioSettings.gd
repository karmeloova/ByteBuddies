extends Control
@export var sliders_tab : Array[Slider]
var music_volumes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.play_music.emit(load("res://Audio/BackgroundMusic.mp3"))
	SignalManager.save_settings.connect(_on_save_settings)
	sliders_tab[0].value = VariableManager.volumes_levels[0]
	sliders_tab[1].value = VariableManager.volumes_levels[1]
	sliders_tab[2].value = VariableManager.volumes_levels[2]

func _on_slider_mouse_exited():
	release_focus()

func _on_slider_value_changed(value, extra_arg_0):
	AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(value))

func _on_check_box_toggled(toggled_on, extra_arg_0):
	if(toggled_on) : 
		sliders_tab[extra_arg_0].editable = false
		AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(0))
	else : 
		sliders_tab[extra_arg_0].editable = true
		AudioServer.set_bus_volume_db(extra_arg_0, linear_to_db(sliders_tab[extra_arg_0].value))

func _on_save_settings(saving : bool) :
	if(saving) :
		for i in range(3) :
			VariableManager.volumes_levels[i] = sliders_tab[i].value
	else :
		sliders_tab[0].value = VariableManager.volumes_levels[0]
		sliders_tab[1].value = VariableManager.volumes_levels[1]
		sliders_tab[2].value = VariableManager.volumes_levels[2]
