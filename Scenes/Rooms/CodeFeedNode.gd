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
var lives = 3

func _ready():
	SignalManager.code_feed.connect(_on_code_feed)
	SignalManager.loseGame.connect(_on_lose_game)

func _on_code_feed_pressed():
	user_code = []
	expected_code = []
	$CodeWindow.text = ""
	$Console.text = ""
	if(VariableManager.food_resource.size() > 0) : 
		set_code_task()
	else :
		$TaskLabel.text = "Nie masz co dać swojemu kotkowi"
	$".".visible = true
	$"../NormalFeed/ScrollContainer".visible = false
	$"../HungryInformation".visible = false

func _on_code_feed_mouse_entered():
	$"../CodeFeed".modulate = Color("b2b2b2")

func _on_code_feed_mouse_exited():
	$"../CodeFeed".modulate = Color("ffffff")

func set_code_task():
	$"../NormalFeed/Feed".disabled = false
	$MinigamesLives.reset_lives()
	$CodeWindow.text = ""
	$Console.text = ""
	loop = loop_array.pick_random()

	what_to_eat = VariableManager.food_resource.pick_random()
	if(loop == "for") : 
		how_many = randi_range(1, what_to_eat.amount)
		expected_code.append("for")
		expected_code.append("i")
		expected_code.append("in")
		expected_code.append("range(" + str(how_many) + "):")
		expected_code.append("eat(" + what_to_eat.item.food_name.to_lower() + ")")
		$TaskLabel.text = "Kotek chce zjeść " + str(how_many) + " " + what_to_eat.item.food_name.to_lower()
		$HintsLabel.text = "Elementy do użycia: \nfor \ni \nin range(" +  str(how_many) + "):\n" + "eat(" + what_to_eat.item.food_name.to_lower() + ")"
	else :
		expected_code.append("while")
		expected_code.append("hungry:")
		expected_code.append("eat(" + what_to_eat.item.food_name.to_lower() + ")")
		$TaskLabel.text = "Karm kotka " + what_to_eat.item.food_name.to_lower() + " dopóki jest głodny"
		$HintsLabel.text = "Elementy do użycia: \nwhile \nhungry \neat(" + what_to_eat.item.food_name.to_lower() + ")"

func _on_code_feed() :
	if($CodeWindow.text.length() > 0) :
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
		$Console.text = ""
		give_prizes()
		good_code()
	else : 
		lives -= 1
		if(lives >= 0) : SignalManager.loseLife.emit()
		$Console.text = ""
		show_errors()

func good_code() :
	if(loop=="for") :
		if(i<how_many) :
			$Console.text += "Eating " + what_to_eat.item.food_name.to_lower() + "\n";
			i += 1
			VariableManager.needs["hungry"] += hungry_points_for_one_feed
			SignalManager.changed_needs.emit()
			$EatTimer.start(0.8)
		if(i >= how_many) :
			$EatTimer.stop()
	else :
		if(i < 5) :
			$Console.text += "hungry == true, eating " + what_to_eat.item.food_name.to_lower() + "\n";
			VariableManager.needs["hungry"] += hungry_points_for_one_feed
			SignalManager.changed_needs.emit()
			i+=1
			$EatTimer.start(0.8)
			return
		if(i == 5) :
			$Console.text += "hungry == false, stop eating";
			$EatTimer.stop()
		
	if(i==5 && loop=="while" || i>=how_many && loop=="for") :
		$"../NormalFeed/Feed".disabled = true
		await get_tree().create_timer(3).timeout
		set_code_task()
	
func show_errors() :
	var lines = 1
	while user_instructions.size() < expected_code.size() :
		user_instructions.append("")
		
	for i in expected_code.size() :
		if(expected_code[i] != user_instructions[i]) :
			if(lives > 0) :
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

func _on_lose_game() :
	get_tree().paused = false

func give_prizes() :
	SignalManager.play_sfx.emit(load("res://Audio/Money.mp3"))
	if(VariableManager.needs["hungry"] < 80) :
		SignalManager.add_fishes.emit()
		VariableManager.eat_counter += 1
		SignalManager.unlock_achievement.emit(VariableManager.eat_counter, "eating", null)
		if(lives > 0) :
			SignalManager.add_exp.emit(10*lives)
			VariableManager.coins += 5*lives
			SignalManager.change_money.emit()
		else :
			SignalManager.add_exp.emit(10)
			VariableManager.coins += 5
			SignalManager.change_money.emit()
