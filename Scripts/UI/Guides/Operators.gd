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
var first_line : String
var second_line : String
var third_line : String
var next_variables : bool

func _on_var_1_text_changed():
	if($".".visible) :
		if(is_tab) :
			$Var1.text = var1
			$Var2.text = var2
		elif(is_enter) :
			$Var1.text = ""
			$Var2.text = ""

func _input(event): 
	if($".".visible == true) :
		if(Input.is_key_pressed(KEY_ENTER)) :
			is_enter = true
			var1 = $Var1.text
			var2 = $Var2.text
			errors_to_show = ""
			if($Var1.text.length() > 0  && $Var2.text.length() > 0) : check_correct()
		else :
			is_enter = false
		
		if(Input.is_action_just_pressed("ui_focus_next") && !Input.is_key_pressed(KEY_SHIFT)) :
			var1 = $Var1.text
			var2 = $Var2.text
			$Var2.grab_focus()
			is_tab = true
		elif(Input.is_action_just_pressed("ui_focus_prev")) :
			is_tab = true
			$Var1.grab_focus()
		else :
			is_tab = false
			
func check_correct() :
	next_variables = true
	$Var1.grab_focus()
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
	if($OperatorsExamples/Aritmetic.visible == true) : aritmetic_operators(number1, number2)
	if($OperatorsExamples/Comparing.visible == true) : comparing_operation(number1, number2)
	if($OperatorsExamples/Logic.visible == true) : logic_operations(number1, number2)
	
	result_to_show = ""

func aritmetic_operators(a : int, b : int) :
	$OperatorsExamples/Aritmetic/Code.text = "print("+str(a)+"+"+str(b)+")\n" + "print("+str(a)+"-"+str(b)+")\n" + "print("+str(a)+"*"+str(b)+")\n" + "print("+str(a)+"/"+str(b)+")\n" + "print("+str(a)+"%"+str(b)+")"
	result_to_show += str(a+b) + "\n"
	result_to_show += str(a-b) + "\n"
	result_to_show += str(a*b) + "\n"
	result_to_show += str(a/b) + "\n"
	result_to_show += str(a%b)
	SignalManager.set_console_text.emit(result_to_show)

func comparing_operation(a : int, b : int) :
	$OperatorsExamples/Comparing/Code.text = "print("+str(a)+"=="+str(b)+")\n" + "print("+str(a)+"!="+str(b)+")\n" + "print("+str(a)+">"+str(b)+")\n" + "print("+str(a)+"<"+str(b)+")\n" + "print("+str(a)+">="+str(b)+")\n" + "print("+str(a)+"<="+str(b)+")"
	result_to_show += str(a==b) + "\n"
	result_to_show += str(a!=b) + "\n"
	result_to_show += str(a>b) + "\n"
	result_to_show += str(a<b) + "\n"
	result_to_show += str(a>=b) + "\n"
	result_to_show += str(a<=b)
	SignalManager.set_console_text.emit(result_to_show)

func logic_operations(a : int, b : int) :
	$OperatorsExamples/Logic/Code.text = "print(" + str(a) + ">" + str(b) + " and " + str(a) + "*" + str(b) + "==10)\n" + "# Sprawdza, czy  a większe od b i czy a*b równe 10\n" + "print(" + str(a) + "*" + str(b) + "<1000" + " or " + str(a) + ">" + str(b) + ")\n" + "# Czy a*b < 1000 lub a większe od b\n" + "print(not(" + str(a) + ">" + str(b) + "*2))"
	result_to_show += str(a>b and a*b==10) + "\n"
	result_to_show += str(a*b<1000 or a>b) + "\n"
	result_to_show += str(not(a>b*2))
	SignalManager.set_console_text.emit(result_to_show)
	
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

func _on_aritmetic_pressed():
	show_good_panel(true, false, false)

func _on_comparing_pressed():
	show_good_panel(false, true, false)

func _on_logic_pressed():
	show_good_panel(false, false, true)

func show_good_panel(bool1 : bool, bool2 : bool, bool3 : bool,) :
	$OperatorsExamples/Aritmetic.visible = bool1
	$OperatorsExamples/Comparing.visible = bool2
	$OperatorsExamples/Logic.visible = bool3
	$"../Console".text = ""
