extends Node
var current_variable : String
var is_enter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if(Input.is_key_pressed(KEY_ENTER)) :
		if($TextEdit.text.length() > 0) :
			current_variable = $TextEdit.text
			is_enter = true
	else :
		is_enter = false

func _on_text_edit_text_changed():
	if(is_enter) : 
		$TextEdit.text = current_variable
		$TextEdit.text = ""
		print_variable()

func print_variable() :
	$Code.text = "x = " + current_variable + "\nprint(x)"
	$CodeEdit.text = ""
	$CodeEdit.text += current_variable
