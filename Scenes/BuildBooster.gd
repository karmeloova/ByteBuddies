extends Node2D
var current_booster : Plan
var instruction_tab : Array[String]
var clear_instruction_tab : Array[String]
var code_field_scene = load("res://Scenes/Prefabs/CodeElement.tscn")
@onready var code_field_node = $CodeInputNode
var code_field_instance
var enter_size = 40
var tab_size = 40
var previous_size
var previous_position
var space = 5
var enter : bool
var tab_count = 0
var next_pos = Vector2.ZERO
var is_booster_correct = true
var check_counter = 0
var ins_counter = 0
var current_field = 0
var iterator = 4
var user_code_elements : Array[String]
var lives = 3

var field_colors = {
	MyEnums.CodeElementsCategories.variable : Color("d0ae9b"),
	MyEnums.CodeElementsCategories.loop : Color("D9A679"),
	MyEnums.CodeElementsCategories.condition : Color("D9A679"),
	MyEnums.CodeElementsCategories.operator : Color("c198b2"),
	MyEnums.CodeElementsCategories.function : Color("A3BEC9"),
	MyEnums.CodeElementsCategories.number : Color("C7B476")
}

func _ready():
	SignalManager.start_build_booster.connect(_on_start_build_booster)
	SignalManager.check_if_is_good.connect(_on_check_if_is_good)
	SignalManager.loseGame.connect(_on_lose_game)
	load_booster_lives()

func _on_start_build_booster(plan : Plan) :
	$".".visible = true
	current_booster = plan
	for corr_ins in current_booster.correct_booster :
		instruction_tab.append(corr_ins.correct_instruction)
	
	set_booster_template()
	set_booster_instruction()
	save_booster_build()

func set_booster_template() :
	for i in range(0, instruction_tab.size()) :
		if(instruction_tab[i]=="enter") :
			if(tab_count > 0) : next_pos.x = 0 + tab_size*tab_count
			else : next_pos.x = 0
			next_pos.y = previous_position.y + enter_size
			continue
		if(instruction_tab[i]=="tab") :
			tab_count += 1
			next_pos.x = 0 + tab_size*tab_count
			continue
		if(instruction_tab[i]=="deletetab") :
			tab_count -= 1
			continue
		
		code_field_instance = code_field_scene.instantiate()
		code_field_instance.set_size_and_text(instruction_tab[i])
		code_field_instance.set_pos(next_pos)
		code_field_instance.set_field_color(field_colors[current_booster.correct_booster[i].instruction_category])
		previous_position = code_field_instance.get_pos()
		previous_size = code_field_instance.get_my_size()
		code_field_node.add_child(code_field_instance)
		next_pos.x = previous_position.x+previous_size+space
		next_pos.y = previous_position.y
		ins_counter += 1
		clear_instruction_tab.append(instruction_tab[i])

func _on_button_pressed():
	user_code_elements.clear()
	check_counter = 0
	is_booster_correct = true
	$BoosterConsole.text = ""
	SignalManager.check_booster_build.emit()

func _on_check_if_is_good(is_good : bool, code : String) :
	check_counter += 1
	user_code_elements.append(code)
	if(is_booster_correct) : is_booster_correct = is_good
	print(is_booster_correct)
	if(check_counter == ins_counter) : 
		if(is_booster_correct) : 
			iterator = current_booster.games_duration-1
			$UseButton.visible = true
			booster_is_good()
		else : 
			if(lives > 0) : 
				lives -= 1
				VariableManager.booster_lives = lives
				SignalManager.loseLife.emit()
			booster_is_bad()

func _on_use_button_pressed():
	VariableManager.try_to_build_booster = false
	VariableManager.booster_lives = 3
	SignalManager.use_booster.emit(current_booster, lives)

func _input(event):
	if(code_field_node.get_child_count() > 0) :
		if(Input.is_action_just_pressed("ui_focus_next") && !Input.is_key_pressed(KEY_SHIFT)) :
			if(current_field+1 < code_field_node.get_child_count()) :
				code_field_node.get_child(current_field+1).get_child(0).grab_focus()
				current_field += 1
		if(Input.is_action_just_pressed("ui_focus_prev")) :
			if(current_field-1 >= 0) :
				code_field_node.get_child(current_field-1).get_child(0).grab_focus()
				current_field -= 1

func set_booster_instruction() :
	if(current_booster.plan_name == "double_exp") :
		$DoubleExpInformation.visible = true
	if(current_booster.plan_name == "double_coins") :
		$DoubleCoinsInformation.visible = true

func booster_is_good():
	if(iterator == current_booster.games_duration - 1) :
		if(current_booster.booster_category == MyEnums.BoosterCategory.exp) :
			$BoosterConsole.text += "Podwajam exp zdobyty w grze. Pozostało gier: " + str(iterator)
		elif(current_booster.booster_category == MyEnums.BoosterCategory.coins) :
			$BoosterConsole.text += "Podwajam monety zdobyte w grze. Pozostało gier: " + str(iterator)
		$FuncTimer.start()
	elif(iterator >= 0) :
		if(current_booster.booster_category == MyEnums.BoosterCategory.exp) :
			$BoosterConsole.text += "\nPodwajam exp zdobyty w grze. Pozostało gier: " + str(iterator)
		elif(current_booster.booster_category == MyEnums.BoosterCategory.coins) :
			$BoosterConsole.text += "Podwajam monety zdobyte w grze. Pozostało gier: " + str(iterator)

func _on_func_timer_timeout():
	iterator -= 1
	booster_is_good()

func booster_is_bad():
	var line_number = 0
	for i in clear_instruction_tab.size():
		if(user_code_elements[i] != clear_instruction_tab[i]) :
			if(line_number==0) : 
				$BoosterConsole.text += "Błąd w polu nr " + str(i)
			else : $BoosterConsole.text += "\nBłąd w polu nr " + str(i)
			line_number += 1
			if(lives == 0) :
				$BoosterConsole.text += "\n\tOczekiwano: " + clear_instruction_tab[i] + " Otrzymano: " + user_code_elements[i]

func _on_lose_game() :
	get_tree().paused = false

func save_booster_build() :
	VariableManager.try_to_build_booster = true
	VariableManager.booster_lives = lives

func load_booster_lives() :
	if(VariableManager.try_to_build_booster) :
		lives = VariableManager.booster_lives
		for i in 3-VariableManager.booster_lives :
			SignalManager.loseLife.emit()
