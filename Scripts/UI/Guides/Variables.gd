extends Node
var current_variable : String
var is_enter

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
	SignalManager.set_console_text.emit(current_variable)
