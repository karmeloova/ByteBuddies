extends Node
var is_enter
var current_text
var identified_type 
var error_message
var is_good
var code_to_set : String
var console_text_to_set : String

func _ready():
	SignalManager.show_test_node.connect(_on_show_test_node)
	SignalManager.hide_test_node.connect(_on_hide_test_node)

func _input(event):
	if($".".visible == true) :
		if(Input.is_key_pressed(KEY_ENTER)) :
			is_enter = true
			if($TestNode/var.text.length() > 0) : 
				current_text = $TestNode/var.text
				identify_type()
		else : is_enter = false

func _on_var_text_changed():
	if(is_enter) :
		$TestNode/var.text = ""
	
func identify_type():
	is_good = false

	if(current_text[0] == "\"") : 
		for i in current_text.length() :
			if(current_text[i] == "\"" && i != current_text.length()-1 && i != 0) :
				if(current_text[i-1] != "\\") :
					error_message = "Niepoprawnie użyłeś cudzysłowia. Jeżeli chcesz dodać cudzysłów w tekście poprzedź go odwróconym ukośnikiem (\\)"
					SignalManager.set_console_text.emit(error_message)
					return
		
		if(current_text[current_text.length()-1] == "\"") : 
			identified_type = "str"
			is_good = true

	if(str(current_text.to_int()) == current_text) : 
		identified_type = "int"
		is_good = true

	if(str(current_text.to_float()) == current_text && !is_good) : 
		identified_type = "float"
		is_good = true
	
	if(current_text == "true" || current_text == "false" ) :
		identified_type = "bool"
		is_good = true
	
	if(is_good) :
		set_code_text()
		set_console_text()
	else :
		error_message = "Niepoprawnie wprowadzono dane."
		SignalManager.set_console_text.emit(error_message)

func set_code_text() :
	code_to_set = ""
	code_to_set += "x = " + str(current_text) + "\n"
	code_to_set += "print(\"Wartość x: \", x)" + "\n"
	code_to_set += "print(\"Typ x: \", type(x))"
	$TestNode/Code.text = code_to_set

func set_console_text() :
	console_text_to_set = ""
	console_text_to_set += "Wartość x: " + current_text + "\n"
	console_text_to_set += "Typ x: " + identified_type
	SignalManager.set_console_text.emit(console_text_to_set)

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
