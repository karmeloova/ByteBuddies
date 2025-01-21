extends Node2D
var expected_word : String

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
		SignalManager.check_if_is_good.emit(true)
	else :
		SignalManager.check_if_is_good.emit(false)
