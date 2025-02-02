extends TextEdit

func _ready():
	SignalManager.set_console_text.connect(_on_set_console_text)
	SignalManager.set_text_using_loops.connect(_on_set_text_using_loops)
	SignalManager.set_text_using_while_loop.connect(_on_set_text_using_while_loop)

func _on_set_console_text(text_to_set : String) :
	text = ""
	text = text_to_set

func _on_set_text_using_loops(iteration_number : int, text_to_set : String) :
	text = ""
	for i in range(iteration_number) :
		if(i==0) : text += text_to_set + str(i)
		else : text += "\n" + text_to_set + str(i)
		await get_tree().create_timer(1.0).timeout
		
	SignalManager.set_text_edit_editable.emit()

func _on_set_text_using_while_loop(max_number : int, text_to_set : String) :
	var number = 1
	var iterations = 0
	text = ""
	while number < max_number :
		if(iterations == 0) : text += text_to_set + str(number)
		else : text += "\n" + text_to_set + str(number)
		number *= 2
		iterations += 1
		await get_tree().create_timer(1.0).timeout
	
	SignalManager.set_text_edit_editable.emit()

func _input(event):
	if(Input.is_key_pressed(KEY_ESCAPE)) :
		$"..".visible = !$"..".visible
		SignalManager.show_test_node.emit()
