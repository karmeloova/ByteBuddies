extends Node2D
@onready var click_sfx = load("res://Audio/Button.mp3")
var current_music
var current_sfx

func _ready():
	SignalManager.play_music.connect(_on_play_music)
	SignalManager.play_sfx.connect(_on_play_sfx)
	SignalManager.changed_scene.connect(_on_changed_scene)
	
func _on_any_button_pressed() :
	$SFX.stream = click_sfx
	$SFX.play()

func _on_area2d_button_pressed(_viewport, event, _shape_idx) :
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) :
		$SFX.stream = click_sfx
		$SFX.play()

func _on_play_music(music) :
	current_music = music
	$Music.stream = current_music
	$Music.play()
	
func _on_play_sfx(sfx) :
	current_sfx = sfx
	$SFX.stream = current_sfx
	$SFX.play()

func _on_changed_scene() :
	for button in get_tree().get_nodes_in_group("Button"):
		if(button.has_signal("pressed")) : 
			if not button.pressed.is_connected(_on_any_button_pressed):
				button.pressed.connect(_on_any_button_pressed.bind())
		elif(button.has_signal("input_event")) : 
			if not button.input_event.is_connected(_on_area2d_button_pressed) :
				button.input_event.connect(_on_area2d_button_pressed.bind())
