extends Node
var var1 = ""
var var2 = ""
var is_enter : bool
var is_tab : bool
var result_to_show = ""
var errors_to_show = ""
var number1 : int
var number2 : int
var is_bad = [false, false]
var second_call : bool
var first_line : String
var second_line : String
var third_line : String
var next_variables : bool

func _ready():
	SignalManager.show_test_node.connect(_on_show_test_node)
	SignalManager.hide_test_node.connect(_on_hide_test_node)

func _on_var_1_text_changed():
	if($".".visible) :
		if(is_enter && !next_variables || is_tab) :
			$TestNode/Var1.text = var1
			$TestNode/Var2.text = var2
		elif(is_enter && next_variables) :
			$TestNode/Var1.text = ""
			$TestNode/Var2.text = ""
	
func _input(event): 
	if($".".visible == true) :
		if(Input.is_key_pressed(KEY_ENTER)) :
			is_enter = true
			var1 = $TestNode/Var1.text
			var2 = $TestNode/Var2.text
			errors_to_show = ""
			check_correct()
		else :
			is_enter = false
		
		if(Input.is_action_just_pressed("ui_focus_next") && !Input.is_key_pressed(KEY_SHIFT)) :
			var1 = $TestNode/Var1.text
			var2 = $TestNode/Var2.text
			$TestNode/Var2.grab_focus()
			is_tab = true
		elif(Input.is_action_just_pressed("ui_focus_prev")) :
			is_tab = true
			$TestNode/Var1.grab_focus()
		else :
			is_tab = false

func check_correct() :
	next_variables = true
	$TestNode/Var1.grab_focus()
	is_bad = [false, false]
	for i in var1.length() :
		if(!is_number(char_to_int(var1[i]))) :
			is_bad[0] = true
			break
		
	for i in var2.length() :
		if(!is_number(char_to_int(var2[i]))) :
			is_bad[1] = true
			break
	
	if(is_bad[0] && !is_bad[1]) : 
		errors_to_show = "Zmienna 1 nie jest liczbą."
		SignalManager.set_console_text.emit(errors_to_show)
		return
	elif(!is_bad[0] && is_bad[1]) :
		errors_to_show = "Zmienna 2 nie jest liczbą."
		SignalManager.set_console_text.emit(errors_to_show)
		return
	elif(is_bad[0] && is_bad[1]) :
		errors_to_show += "Zmienna 1 nie jest liczbą.\n"
		errors_to_show += "Zmienna 2 nie jest liczbą."
		SignalManager.set_console_text.emit(errors_to_show)
		return
		
	number1 = var1.to_int()
	number2 = var2.to_int()

	result_to_show += str(number1+number2)
	if(!second_call) :
		result_to_show += "\nTeraz drugi raz\n"
	else : 
		SignalManager.set_console_text.emit(result_to_show)
	
	prepare_text_edits()

func is_number(ascii: int) -> bool:
	if(ascii >= 48 and ascii <= 57) :
		return true
	else :
		return false

func byte_to_int(ascii_bufer: PackedByteArray) :
	var ascii;
	for byte in ascii_bufer :
		ascii = int(byte)
		
	return ascii
	
func char_to_int(char) -> int:
	return byte_to_int(char.to_ascii_buffer())

func prepare_text_edits() :
	
	if(!second_call) :
		second_call = true
		first_line = "print(add_numbers("+str(number1) + "," + str(number2) + "))\n"
		second_line = "print(\"Teraz drugi raz\")\n"
		third_line = "print(add_numbers([twoje_zmienne2]))\n\n"
		$TestNode/Code.text = ""
		$TestNode/Code.text += first_line
		$TestNode/Code.text += second_line
		$TestNode/Code.text += third_line
		$TestNode/Code.text += "def add_numbers(a,b)\n\treturn a+b"
		
	else :
		second_call = false
		result_to_show = ""
		third_line = "print(add_numbers("+str(number1) + "," + str(number2) + "))\n\n"
		$TestNode/Code.text = ""
		$TestNode/Code.text += first_line
		$TestNode/Code.text += second_line
		$TestNode/Code.text += third_line
		$TestNode/Code.text += "def add_numbers(a,b)\n\treturn a+b"

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
