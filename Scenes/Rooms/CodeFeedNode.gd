extends Node2D

var loop_array = ["for", "while"]
var user_code
var expected_code = []
var what_to_eat
var how_many = 1
var loop
var i = 0
var hungry_points_for_one_feed
var user_instructions = []
var how_many_check = 0

func _ready():
	SignalManager.code_feed.connect(_on_code_feed)

func _on_code_feed_pressed():
	user_code = []
	expected_code = []
	$CodeWindow.text = ""
	$Console.text = ""
	if(VariableManager.food_list.size() > 0) : 
		set_code_task()
	else :
		$TaskLabel.text = "Nie masz co dać swojemu kotkowi"
	$".".visible = true
	$"../NormalFeed/ScrollContainer".visible = false

func _on_code_feed_mouse_entered():
	$"../CodeFeed".modulate = Color("b2b2b2")

func _on_code_feed_mouse_exited():
	$"../CodeFeed".modulate = Color("ffffff")

func set_code_task():
	loop = loop_array.pick_random()

	what_to_eat = VariableManager.food_list.pick_random()
	if(loop == "for") : 
		how_many = randi_range(1, what_to_eat.amount)
		expected_code.append("for")
		expected_code.append("i")
		expected_code.append("in")
		expected_code.append("range(" + str(how_many) + ")")
		expected_code.append("eat(" + what_to_eat.food_name.to_lower() + ")")
		$TaskLabel.text = "Kotek chce zjeść " + str(how_many) + " " + what_to_eat.food_name.to_lower()
		$HintsLabel.text = "Elementy do użycia: \nfor \ni \nin range(" +  str(how_many) + ")\n" + "eat(" + what_to_eat.food_name.to_lower() + ")"
	else :
		expected_code.append("while")
		expected_code.append("hungry")
		expected_code.append("eat(" + what_to_eat.food_name.to_lower() + ")")
		$TaskLabel.text = "Karm kotka " + what_to_eat.food_name.to_lower() + " dopóki jest głodny"
		$HintsLabel.text = "Elementy do użycia: \nwhile \nhungry \neat(" + what_to_eat.food_name.to_lower() + ")"

func _on_code_feed() :
	if($CodeWindow.text != null) :
		user_code = $CodeWindow.text
		user_code += " "
		split_user_code()
		
func split_user_code() :
	user_instructions = []
	var ins = ""
	for char in user_code :
		if(char != " " && char != "\n" && char != "\t") :
			ins += char
		else :
			if(ins.length() > 0) : user_instructions.append(ins)
			ins = ""

	if(user_instructions == expected_code) : 
		i = 0
		if(loop=="for") : hungry_points_for_one_feed = (100 - VariableManager.needs["hungry"])/how_many
		else : hungry_points_for_one_feed = (100 - VariableManager.needs["hungry"])/5
		good_code()
	else : 
		how_many_check += 1
		$Console.text = ""
		show_errors()

func good_code() :
	if(loop=="for") :
		if(i<how_many) :
			$Console.text += "Eating " + what_to_eat.food_name.to_lower() + "\n";
			i += 1
			VariableManager.needs["hungry"] += hungry_points_for_one_feed
			SignalManager.changed_needs.emit()
			$EatTimer.start(0.8)
		if(i >= how_many) :
			$EatTimer.stop()
	else :
		if(i < 5) :
			$Console.text += "hungry == true, eating " + what_to_eat.food_name.to_lower() + "\n";
			VariableManager.needs["hungry"] += hungry_points_for_one_feed
			SignalManager.changed_needs.emit()
			i+=1
			$EatTimer.start(0.8)
			return
		if(i == 5) :
			$Console.text += "hungry == false, stop eating";
			$EatTimer.stop()

func show_errors() :
	print(user_instructions)
	print(expected_code)
	
	var lines = 1
	while user_instructions.size() < expected_code.size() :
		user_instructions.append("")
		
	for i in expected_code.size() :
		if(expected_code[i] != user_instructions[i]) :
			if(how_many_check <= 2) :
				$Console.text += "Błąd w wyrazie " + str(lines) + "\n"
			else :
				$Console.text += "Błąd w wyrazie " + str(lines) + "\n\toczekiwano " + expected_code[i] + "\n\totrzymano " + user_instructions[i] + "\n"
		lines += 1
	
	if(user_instructions.size() > expected_code.size()) : $Console.text += "Twój kod jest za długi o " + str(user_instructions.size() - expected_code.size()) + " wyraz (-y)"

func _on_information_button_mouse_entered():
	$Information/InformationButton.modulate = Color("b2b2b2")
	$Information/Icon.modulate = Color("b2b2b2")
	$Information/InformationNode.visible = true

func _on_information_button_mouse_exited():
	$Information/InformationButton.modulate = Color("ffffff")
	$Information/Icon.modulate = Color("ffffff")
	$Information/InformationNode.visible = false
