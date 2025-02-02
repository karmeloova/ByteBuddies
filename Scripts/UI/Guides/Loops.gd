extends Node
var is_enter : bool
var current_text : String

func _ready():
	SignalManager.set_text_edit_editable.connect(_on_set_text_edit_editable)
	SignalManager.show_test_node.connect(_on_show_test_node)
	SignalManager.hide_test_node.connect(_on_hide_test_node)

func _on_for_pressed():
	$TestNode/ForLoop.visible = true
	$TestNode/WhileLoop.visible = false
	$"../Console/Console".text = ""

func _on_while_pressed():
	$TestNode/ForLoop.visible = false
	$TestNode/WhileLoop.visible = true
	$"../Console/Console".text = ""

func _input(event):
	if($".".visible == true) :
		if(Input.is_key_pressed(KEY_ENTER)) :
			is_enter = true
			if($TestNode/ForLoop.visible == true) : current_text = $TestNode/ForLoop/var.text
			elif($TestNode/WhileLoop.visible == true) : current_text = $TestNode/WhileLoop/var.text
			check_string()
		else : is_enter = false

func check_string() :
	for i in current_text.length() :
		if(!is_number(char_to_int(current_text[i]))) :
			SignalManager.set_console_text.emit("To nie jest liczba całkowita.")
			return
	
	$TestNode/ForLoop/var.text = ""
	$TestNode/WhileLoop/var.text = ""
	
	if(current_text.length() >= 1) :
		if($TestNode/ForLoop.visible == true) :
			SignalManager.set_text_using_loops.emit(current_text.to_int(), "Krok nr ")
			$TestNode/ForLoop/RichTextLabel.text = "for i in range(" + current_text + ")\n\tprint(\"Krok nr \", i)\n\ttime.sleep(1)"
			$TestNode/ForLoop/var.editable = false
		if($TestNode/WhileLoop.visible == true) :
			SignalManager.set_text_using_while_loop.emit(current_text.to_int(), "Obecna wartosc: ")
			$TestNode/WhileLoop/RichTextLabel.text = "number = 1\nwhile number < " + current_text + ":\n\tprint(\"Obecna wartosc: \", number)\n\tnumber = number * 2\n\ttime.sleep(1)"
			$TestNode/WhileLoop/var.editable = false
			
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

func _on_var_text_changed():
	if(is_enter) :
		$TestNode/ForLoop/var.text = ""
		$TestNode/WhileLoop/var.text = ""

func _on_set_text_edit_editable() :
	$TestNode/ForLoop/var.editable = true
	$TestNode/WhileLoop/var.editable = true
	
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
