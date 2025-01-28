extends Node
var is_enter : bool
var current_text : String

func _input(event):
	if($".".visible == true) :
		if(Input.is_key_pressed(KEY_ENTER)) :
			is_enter = true
			current_text = $var.text
			check_string()
		else : is_enter = false

func check_string() :
	for i in current_text.length() :
		if(!is_number(char_to_int(current_text[i]))) :
			SignalManager.set_console_text.emit("To nie jest liczba całkowita.")
			return
	
	$var.text = ""
	
	if(current_text.length() >= 1) :
		$RichTextLabel2.text = "if " + current_text + "%2==0 :\n\tprint(\"Liczba parzysta\")\nelse:\n\tprint(\"Liczba nieparzysta\")"
		if(current_text.to_int() % 2 == 0) :
			SignalManager.set_console_text.emit("Liczba parzysta")
		else :
			SignalManager.set_console_text.emit("Liczba nieparzysta")
			
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
		$var.text = ""
