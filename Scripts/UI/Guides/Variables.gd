extends Node
var current_variable : String
var is_enter
var size_with_test
var size_without_test = 397


func _ready():
	SignalManager.show_test_node.connect(_on_show_test_node)
	SignalManager.hide_test_node.connect(_on_hide_test_node)

func _input(event):
	if(Input.is_key_pressed(KEY_ENTER)) :
		if($TestNode/TextEdit.text.length() > 0) :
			current_variable = $TestNode/TextEdit.text
			is_enter = true
	else :
		is_enter = false

func _on_text_edit_text_changed():
	if(is_enter) : 
		$TestNode/TextEdit.text = current_variable
		$TestNode/TextEdit.text = ""
		print_variable()

func print_variable() :
	$TestNode/Code.text = "x = " + current_variable + "\nprint(x)"
	SignalManager.set_console_text.emit(current_variable)

func _on_show_test_node() :
	if($".".visible==true) :
		$TestNode.visible = !$TestNode.visible 
	if(!$TestNode.visible) :
		$Tutorial.size.y = 397
	else :
		$Tutorial.size.y = 147

func _on_hide_test_node() :
	$TestNode.visible = false
	$Tutorial.size.y = 397
