extends Node2D
var expected_word : String
var curr_text : String
var is_tab : bool
var good_code_color = Color("8BA17D")

func _ready():
	SignalManager.check_booster_build.connect(_on_check_booster_build)

func set_size_and_text(word : String) :
	$CodeField.size.x = 10*word.length()+8
	$CodeField.text = word
	expected_word = word

func get_my_size() -> int :
	return $CodeField.size.x

func set_pos(pos) :
	position = pos

func get_pos() -> Vector2 :
	return position

func _on_check_booster_build() :
	if($CodeField.text.length() == 0) : return
	if($CodeField.text == expected_word) :
		SignalManager.check_if_is_good.emit(true, $CodeField.text)
		good_code()
	else :
		SignalManager.check_if_is_good.emit(false, $CodeField.text)

func _on_code_field_text_changed():
	if(is_tab) : $CodeField.text = curr_text

func _input(event):
	if(Input.is_key_pressed(KEY_TAB)) :
		curr_text = $CodeField.text
		is_tab = true
	else :
		is_tab = false

func set_field_color(color : Color) :
	$CodeField.add_theme_color_override("background_color", color)

func good_code() :
	$CodeField.add_theme_color_override("background_color", good_code_color)
	$CodeField.editable = false
